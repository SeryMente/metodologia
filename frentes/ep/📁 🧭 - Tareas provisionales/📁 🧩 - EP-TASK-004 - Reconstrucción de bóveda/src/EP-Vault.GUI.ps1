[CmdletBinding()]
param()

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

if ([Threading.Thread]::CurrentThread.ApartmentState -ne 'STA') {
    $hostExe = Join-Path $PSHOME 'powershell.exe'
    $quotedScript = '"' + $PSCommandPath.Replace('"','""') + '"'
    $arguments = '-NoLogo -NoProfile -ExecutionPolicy Bypass -STA -File ' + $quotedScript
    $child = Start-Process -FilePath $hostExe -ArgumentList $arguments -PassThru -Wait
    exit $child.ExitCode
}

Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase
$corePath = Join-Path $PSScriptRoot 'EP.Vault.Core.psm1'
$xamlPath = Join-Path $PSScriptRoot 'EP-Vault.Window.xaml'
if (-not (Test-Path -LiteralPath $corePath -PathType Leaf)) { throw 'EP_VAULT_CORE_NOT_FOUND' }
if (-not (Test-Path -LiteralPath $xamlPath -PathType Leaf)) { throw 'EP_VAULT_XAML_NOT_FOUND' }

Import-Module -Name $corePath -Force -ErrorAction Stop

[xml]$xaml = Get-Content -LiteralPath $xamlPath -Raw -Encoding UTF8
$reader = [System.Xml.XmlNodeReader]::new($xaml)
$script:Ui = [System.Windows.Markup.XamlReader]::Load($reader)
$reader.Close()

# Add named XAML elements as PowerShell note properties for safe event wiring.
$uiNames = @(
    'HeaderState','ClosedStage','OpenStage','UnlockButton','LockButton','MasterPasswordBox',
    'ConfirmPasswordBox','ConfirmLabel','GateTitle','GateDescription','SessionDuration',
    'GateMessage','FooterStatus','SessionRemaining','SessionExpiresAt','VariableNameBox',
    'StoreVariableButton','VariableList','RefreshVariablesButton','RevealVariableButton',
    'RemoveVariableButton','NoteTtl','CaptureNoteButton','NoteList','PromoteNameBox',
    'PromoteNoteButton','RefreshNotesButton','ReadNoteButton','DeleteNoteButton','RevealedValueBox'
)
foreach ($name in $uiNames) {
    $element = $script:Ui.FindName($name)
    if ($null -eq $element) { throw ('UI_ELEMENT_NOT_FOUND: ' + $name) }
    $script:Ui | Add-Member -MemberType NoteProperty -Name $name -Value $element -Force
}

$script:Door = $null
$script:SessionTimer = $null
$script:RevealTimer = $null
$script:OpeningTimer = $null
$script:Closing = $false

function Get-UiElement {
    param([Parameter(Mandatory=$true)][string]$Name)
    $element = $script:Ui.FindName($Name)
    if ($null -eq $element) { throw ('UI_ELEMENT_NOT_FOUND: ' + $Name) }
    return $element
}

function New-UiBrush {
    param([Parameter(Mandatory=$true)][string]$Color)
    return [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString($Color))
}

function New-UiMetalBrush {
    $brush = [System.Windows.Media.LinearGradientBrush]::new()
    $brush.StartPoint = [System.Windows.Point]::new(0,0)
    $brush.EndPoint = [System.Windows.Point]::new(1,1)
    $brush.GradientStops.Add([System.Windows.Media.GradientStop]::new([System.Windows.Media.ColorConverter]::ConvertFromString('#667179'),0.0))
    $brush.GradientStops.Add([System.Windows.Media.GradientStop]::new([System.Windows.Media.ColorConverter]::ConvertFromString('#303A40'),0.22))
    $brush.GradientStops.Add([System.Windows.Media.GradientStop]::new([System.Windows.Media.ColorConverter]::ConvertFromString('#11171B'),0.58))
    $brush.GradientStops.Add([System.Windows.Media.GradientStop]::new([System.Windows.Media.ColorConverter]::ConvertFromString('#59636A'),1.0))
    return $brush
}

function Add-DoorEllipse {
    param(
        [double]$Left,
        [double]$Top,
        [double]$Width,
        [double]$Height,
        [string]$Fill,
        [string]$Stroke = '#000000',
        [double]$StrokeWidth = 1,
        [switch]$NoFill
    )
    $shape = [System.Windows.Shapes.Ellipse]::new()
    $shape.Width = $Width
    $shape.Height = $Height
    if ($NoFill) { $shape.Fill = [System.Windows.Media.Brushes]::Transparent }
    elseif ($Fill -eq 'METAL') { $shape.Fill = New-UiMetalBrush }
    else { $shape.Fill = New-UiBrush -Color $Fill }
    $shape.Stroke = New-UiBrush -Color $Stroke
    $shape.StrokeThickness = $StrokeWidth
    [System.Windows.Controls.Canvas]::SetLeft($shape,$Left)
    [System.Windows.Controls.Canvas]::SetTop($shape,$Top)
    [void](Get-UiElement -Name 'VaultCanvas').Children.Add($shape)
    return $shape
}

function Add-DoorLine {
    param([double]$X1,[double]$Y1,[double]$X2,[double]$Y2,[string]$Color='#927448',[double]$Width=2)
    $line = [System.Windows.Shapes.Line]::new()
    $line.X1=$X1; $line.Y1=$Y1; $line.X2=$X2; $line.Y2=$Y2
    $line.Stroke = New-UiBrush -Color $Color
    $line.StrokeThickness = $Width
    $line.StrokeStartLineCap = [System.Windows.Media.PenLineCap]::Round
    $line.StrokeEndLineCap = [System.Windows.Media.PenLineCap]::Round
    [void](Get-UiElement -Name 'VaultCanvas').Children.Add($line)
    return $line
}

function Build-CleanRoomVaultDoor {
    $canvas = Get-UiElement -Name 'VaultCanvas'
    $canvas.Children.Clear()

    $glow = Add-DoorEllipse -Left 8 -Top 8 -Width 624 -Height 624 -Fill '#11191D' -Stroke '#202A2E' -StrokeWidth 2
    $glow.Effect = [System.Windows.Media.Effects.DropShadowEffect]::new()
    $glow.Effect.Color = [System.Windows.Media.Colors]::Black
    $glow.Effect.BlurRadius = 38
    $glow.Effect.ShadowDepth = 0
    $glow.Effect.Opacity = 0.8

    $null = Add-DoorEllipse -Left 25 -Top 25 -Width 590 -Height 590 -Fill 'METAL' -Stroke '#9A8157' -StrokeWidth 8
    $null = Add-DoorEllipse -Left 47 -Top 47 -Width 546 -Height 546 -Fill '#202A2F' -Stroke '#667179' -StrokeWidth 3
    $null = Add-DoorEllipse -Left 67 -Top 67 -Width 506 -Height 506 -Fill '#182126' -Stroke '#927448' -StrokeWidth 2
    $null = Add-DoorEllipse -Left 85 -Top 85 -Width 470 -Height 470 -Fill 'METAL' -Stroke '#0A0E10' -StrokeWidth 3
    $null = Add-DoorEllipse -Left 109 -Top 109 -Width 422 -Height 422 -Fill '#171F23' -Stroke '#657078' -StrokeWidth 2
    $null = Add-DoorEllipse -Left 132 -Top 132 -Width 376 -Height 376 -Fill '#222C31' -Stroke '#927448' -StrokeWidth 2
    $null = Add-DoorEllipse -Left 154 -Top 154 -Width 332 -Height 332 -Fill '#12191D' -Stroke '#4E5A60' -StrokeWidth 2

    for ($i=0; $i -lt 60; $i++) {
        $angle = ($i * 6.0 - 90.0) * [Math]::PI / 180.0
        $radius1 = if (($i % 5) -eq 0) { 249.0 } else { 254.0 }
        $radius2 = 263.0
        $x1 = 320 + [Math]::Cos($angle) * $radius1
        $y1 = 320 + [Math]::Sin($angle) * $radius1
        $x2 = 320 + [Math]::Cos($angle) * $radius2
        $y2 = 320 + [Math]::Sin($angle) * $radius2
        $color = if (($i % 5) -eq 0) { '#C3A36A' } else { '#586267' }
        $width = if (($i % 5) -eq 0) { 2.2 } else { 1.0 }
        $null = Add-DoorLine -X1 $x1 -Y1 $y1 -X2 $x2 -Y2 $y2 -Color $color -Width $width
    }

    $script:Door = [ordered]@{ Bolts = @(); Wheel = $null; Rotate = $null; Translate = $null; Scale = $null }

    for ($i=0; $i -lt 12; $i++) {
        $angle = ($i * 30.0 - 90.0) * [Math]::PI / 180.0
        $radius = 275.0
        $cx = 320 + [Math]::Cos($angle) * $radius
        $cy = 320 + [Math]::Sin($angle) * $radius
        $bolt = [System.Windows.Shapes.Ellipse]::new()
        $bolt.Width = 40
        $bolt.Height = 32
        $bolt.Fill = New-UiMetalBrush
        $bolt.Stroke = New-UiBrush -Color '#C0A06A'
        $bolt.StrokeThickness = 2
        $bolt.Effect = [System.Windows.Media.Effects.DropShadowEffect]::new()
        $bolt.Effect.Color = [System.Windows.Media.Colors]::Black
        $bolt.Effect.BlurRadius = 8
        $bolt.Effect.ShadowDepth = 3
        [System.Windows.Controls.Canvas]::SetLeft($bolt,$cx-20)
        [System.Windows.Controls.Canvas]::SetTop($bolt,$cy-16)
        $transform = [System.Windows.Media.TranslateTransform]::new(0,0)
        $bolt.RenderTransform = $transform
        [void]$canvas.Children.Add($bolt)
        $script:Door.Bolts += [pscustomobject]@{
            Transform = $transform
            DeltaX = -[Math]::Cos($angle)*19
            DeltaY = -[Math]::Sin($angle)*19
        }
    }

    $wheel = [System.Windows.Controls.Canvas]::new()
    $wheel.Width = 210
    $wheel.Height = 210
    [System.Windows.Controls.Canvas]::SetLeft($wheel,215)
    [System.Windows.Controls.Canvas]::SetTop($wheel,215)
    $wheelTransform = [System.Windows.Media.RotateTransform]::new(0,105,105)
    $wheel.RenderTransform = $wheelTransform

    $wheelOuter = [System.Windows.Shapes.Ellipse]::new()
    $wheelOuter.Width = 210
    $wheelOuter.Height = 210
    $wheelOuter.Fill = New-UiBrush -Color '#252E33'
    $wheelOuter.Stroke = New-UiBrush -Color '#C3A36A'
    $wheelOuter.StrokeThickness = 5
    [void]$wheel.Children.Add($wheelOuter)

    $wheelInner = [System.Windows.Shapes.Ellipse]::new()
    $wheelInner.Width = 154
    $wheelInner.Height = 154
    $wheelInner.Margin = [System.Windows.Thickness]::new(28)
    $wheelInner.Fill = New-UiBrush -Color '#11171B'
    $wheelInner.Stroke = New-UiBrush -Color '#6F5A39'
    $wheelInner.StrokeThickness = 2
    [void]$wheel.Children.Add($wheelInner)

    for ($i=0; $i -lt 8; $i++) {
        $angle = ($i * 45.0) * [Math]::PI / 180.0
        $spoke = [System.Windows.Shapes.Line]::new()
        $spoke.X1 = 105 + [Math]::Cos($angle)*43
        $spoke.Y1 = 105 + [Math]::Sin($angle)*43
        $spoke.X2 = 105 + [Math]::Cos($angle)*88
        $spoke.Y2 = 105 + [Math]::Sin($angle)*88
        $spoke.Stroke = New-UiBrush -Color '#B08D54'
        $spoke.StrokeThickness = 8
        $spoke.StrokeStartLineCap = [System.Windows.Media.PenLineCap]::Round
        $spoke.StrokeEndLineCap = [System.Windows.Media.PenLineCap]::Round
        [void]$wheel.Children.Add($spoke)
    }

    $hub = [System.Windows.Shapes.Ellipse]::new()
    $hub.Width = 68
    $hub.Height = 68
    [System.Windows.Controls.Canvas]::SetLeft($hub,71)
    [System.Windows.Controls.Canvas]::SetTop($hub,71)
    $hub.Fill = New-UiMetalBrush
    $hub.Stroke = New-UiBrush -Color '#D0AD70'
    $hub.StrokeThickness = 3
    [void]$wheel.Children.Add($hub)

    $hubCenter = [System.Windows.Shapes.Ellipse]::new()
    $hubCenter.Width = 20
    $hubCenter.Height = 20
    [System.Windows.Controls.Canvas]::SetLeft($hubCenter,95)
    [System.Windows.Controls.Canvas]::SetTop($hubCenter,95)
    $hubCenter.Fill = New-UiBrush -Color '#0A0E10'
    [void]$wheel.Children.Add($hubCenter)

    [void]$canvas.Children.Add($wheel)
    $script:Door.Wheel = $wheelTransform

    $label = [System.Windows.Controls.TextBlock]::new()
    $label.Text = 'EP  /  SEALED CHAMBER'
    $label.FontFamily = [System.Windows.Media.FontFamily]::new('Bahnschrift')
    $label.FontSize = 10
    $label.Foreground = New-UiBrush -Color '#C3A36A'
    $label.Width = 240
    $label.TextAlignment = [System.Windows.TextAlignment]::Center
    [System.Windows.Controls.Canvas]::SetLeft($label,200)
    [System.Windows.Controls.Canvas]::SetTop($label,135)
    [void]$canvas.Children.Add($label)

    $group = [System.Windows.Media.TransformGroup]::new()
    $rotate = [System.Windows.Media.RotateTransform]::new(0,320,320)
    $translate = [System.Windows.Media.TranslateTransform]::new(0,0)
    $scale = [System.Windows.Media.ScaleTransform]::new(1,1,320,320)
    [void]$group.Children.Add($rotate)
    [void]$group.Children.Add($translate)
    [void]$group.Children.Add($scale)
    $canvas.RenderTransform = $group
    $script:Door.Rotate = $rotate
    $script:Door.Translate = $translate
    $script:Door.Scale = $scale
}

function Reset-CleanRoomVaultDoor {
    if ($null -eq $script:Door) { return }
    $canvas = Get-UiElement -Name 'VaultCanvas'
    $canvas.BeginAnimation([System.Windows.UIElement]::OpacityProperty,$null)
    $canvas.RenderTransform.Children[0].BeginAnimation([System.Windows.Media.RotateTransform]::AngleProperty,$null)
    $canvas.RenderTransform.Children[1].BeginAnimation([System.Windows.Media.TranslateTransform]::XProperty,$null)
    $canvas.RenderTransform.Children[2].BeginAnimation([System.Windows.Media.ScaleTransform]::ScaleXProperty,$null)
    $script:Door.Wheel.BeginAnimation([System.Windows.Media.RotateTransform]::AngleProperty,$null)
    foreach ($bolt in $script:Door.Bolts) {
        $bolt.Transform.BeginAnimation([System.Windows.Media.TranslateTransform]::XProperty,$null)
        $bolt.Transform.BeginAnimation([System.Windows.Media.TranslateTransform]::YProperty,$null)
        $bolt.Transform.X = 0
        $bolt.Transform.Y = 0
    }
    $script:Door.Rotate.Angle = 0
    $script:Door.Translate.X = 0
    $script:Door.Translate.Y = 0
    $script:Door.Scale.ScaleX = 1
    $script:Door.Scale.ScaleY = 1
    $script:Door.Wheel.Angle = 0
    $canvas.Opacity = 1
}

function Start-CleanRoomOpeningSequence {
    $window = $script:Ui
    $canvas = Get-UiElement -Name 'VaultCanvas'
    if (-not [System.Windows.SystemParameters]::ClientAreaAnimation) {
        $canvas.Visibility = [System.Windows.Visibility]::Collapsed
        $window.ClosedStage.Visibility = [System.Windows.Visibility]::Collapsed
        $window.OpenStage.Visibility = [System.Windows.Visibility]::Visible
        $window.HeaderState.Text = 'ABIERTA'
        $window.FooterStatus.Text = 'LOCAL · SESIÓN AUTENTICADA · MOVIMIENTO REDUCIDO'
        Refresh-EpVariables
        Refresh-EpNotes
        Update-EpSessionDisplay
        Start-EpSessionTimer
        return
    }
    Reset-CleanRoomVaultDoor
    $canvas.Visibility = [System.Windows.Visibility]::Visible
    $window.OpenStage.Visibility = [System.Windows.Visibility]::Collapsed
    $window.ClosedStage.Visibility = [System.Windows.Visibility]::Visible
    $window.HeaderState.Text = 'DESBLOQUEANDO'
    $window.FooterStatus.Text = 'AUTENTICACIÓN VÁLIDA · MECANISMO EN MOVIMIENTO'

    $duration = [TimeSpan]::FromMilliseconds(620)
    foreach ($bolt in $script:Door.Bolts) {
        $ease = [System.Windows.Media.Animation.CubicEase]::new()
        $ease.EasingMode = [System.Windows.Media.Animation.EasingMode]::EaseInOut
        $xAnimation = [System.Windows.Media.Animation.DoubleAnimation]::new($bolt.DeltaX,$duration)
        $yAnimation = [System.Windows.Media.Animation.DoubleAnimation]::new($bolt.DeltaY,$duration)
        $xAnimation.EasingFunction = $ease
        $yAnimation.EasingFunction = $ease
        $bolt.Transform.BeginAnimation([System.Windows.Media.TranslateTransform]::XProperty,$xAnimation)
        $bolt.Transform.BeginAnimation([System.Windows.Media.TranslateTransform]::YProperty,$yAnimation)
    }

    $wheelEase = [System.Windows.Media.Animation.CubicEase]::new()
    $wheelEase.EasingMode = [System.Windows.Media.Animation.EasingMode]::EaseOut
    $wheelAnimation = [System.Windows.Media.Animation.DoubleAnimation]::new(0,165,[TimeSpan]::FromMilliseconds(1050))
    $wheelAnimation.EasingFunction = $wheelEase
    $script:Door.Wheel.BeginAnimation([System.Windows.Media.RotateTransform]::AngleProperty,$wheelAnimation)

    $doorEase = [System.Windows.Media.Animation.CubicEase]::new()
    $doorEase.EasingMode = [System.Windows.Media.Animation.EasingMode]::EaseIn
    $rotateAnimation = [System.Windows.Media.Animation.DoubleAnimation]::new(0,38,[TimeSpan]::FromMilliseconds(1250))
    $translateAnimation = [System.Windows.Media.Animation.DoubleAnimation]::new(0,390,[TimeSpan]::FromMilliseconds(1250))
    $fadeAnimation = [System.Windows.Media.Animation.DoubleAnimation]::new(1,0,[TimeSpan]::FromMilliseconds(1200))
    $rotateAnimation.EasingFunction=$doorEase
    $translateAnimation.EasingFunction=$doorEase
    $canvas.RenderTransform.Children[0].BeginAnimation([System.Windows.Media.RotateTransform]::AngleProperty,$rotateAnimation)
    $canvas.RenderTransform.Children[1].BeginAnimation([System.Windows.Media.TranslateTransform]::XProperty,$translateAnimation)
    $canvas.BeginAnimation([System.Windows.UIElement]::OpacityProperty,$fadeAnimation)

    if ($script:OpeningTimer) { $script:OpeningTimer.Stop() }
    $script:OpeningTimer = [System.Windows.Threading.DispatcherTimer]::new()
    $script:OpeningTimer.Interval = [TimeSpan]::FromMilliseconds(1350)
    $script:OpeningTimer.Add_Tick({
        $script:OpeningTimer.Stop()
        try {
            $session = Get-EpVaultSession
            $canvas = Get-UiElement -Name 'VaultCanvas'
            $canvas.Visibility = [System.Windows.Visibility]::Collapsed
            $canvas.BeginAnimation([System.Windows.UIElement]::OpacityProperty,$null)
            Get-UiElement -Name 'ClosedStage' | ForEach-Object { $_.Visibility = [System.Windows.Visibility]::Collapsed }
            Get-UiElement -Name 'OpenStage' | ForEach-Object { $_.Visibility = [System.Windows.Visibility]::Visible }
            $script:Ui.HeaderState.Text = 'ABIERTA'
            $script:Ui.FooterStatus.Text = 'LOCAL · SESIÓN AUTENTICADA · TTL ABSOLUTO'
            Refresh-EpVariables
            Refresh-EpNotes
            Update-EpSessionDisplay
            Start-EpSessionTimer
        }
        catch {
            Close-EpVaultUi -Reason 'SESSION_INVALID_AFTER_OPEN'
            Set-EpGateMessage -Message $_.Exception.Message
        }
    })
    $script:OpeningTimer.Start()
}

function Start-EpSessionTimer {
    if ($script:SessionTimer) { $script:SessionTimer.Stop() }
    $script:SessionTimer = [System.Windows.Threading.DispatcherTimer]::new()
    $script:SessionTimer.Interval = [TimeSpan]::FromSeconds(1)
    $script:SessionTimer.Add_Tick({
        try {
            Update-EpSessionDisplay
        }
        catch {
            Close-EpVaultUi -Reason 'SESSION_EXPIRED'
            Set-EpGateMessage -Message 'La sesión venció. La cámara se cerró.'
        }
    })
    $script:SessionTimer.Start()
}

function Update-EpSessionDisplay {
    $session = Get-EpVaultSession
    $remaining = [int]$session.remainingSeconds
    $minutes = [Math]::Floor($remaining / 60)
    $seconds = $remaining % 60
    $script:Ui.SessionRemaining.Text = ('{0:00}:{1:00}' -f $minutes,$seconds)
    $expiresUtc = [DateTimeOffset]::Parse($session.expiresAtUtc).ToUniversalTime()
    $script:Ui.SessionExpiresAt.Text = 'UTC ' + $expiresUtc.ToString('HH:mm:ss')
    if ($remaining -le 30) {
        $script:Ui.SessionRemaining.Foreground = New-UiBrush -Color '#D28B45'
    }
    else {
        $script:Ui.SessionRemaining.Foreground = New-UiBrush -Color '#D2A05B'
    }
}

function Clear-EpRevealedValue {
    if ($script:RevealTimer) { $script:RevealTimer.Stop() }
    $script:Ui.RevealedValueBox.Clear()
    $script:Ui.RevealedValueBox.Visibility = [System.Windows.Visibility]::Collapsed
}

function Show-EpRevealedValue {
    param([Parameter(Mandatory=$true)][string]$Value)
    Clear-EpRevealedValue
    $script:Ui.RevealedValueBox.Text = $Value
    $script:Ui.RevealedValueBox.Visibility = [System.Windows.Visibility]::Visible
    $script:RevealTimer = [System.Windows.Threading.DispatcherTimer]::new()
    $script:RevealTimer.Interval = [TimeSpan]::FromSeconds(15)
    $script:RevealTimer.Add_Tick({
        $script:RevealTimer.Stop()
        Clear-EpRevealedValue
    })
    $script:RevealTimer.Start()
}

function Refresh-EpVariables {
    $script:Ui.VariableList.ItemsSource = $null
    $script:Ui.VariableList.ItemsSource = @(Get-EpVaultVariableNames)
}

function Refresh-EpNotes {
    $script:Ui.NoteList.ItemsSource = $null
    $script:Ui.NoteList.ItemsSource = @(Get-EpVaultNotes)
}

function Set-EpGateMessage {
    param([string]$Message)
    $script:Ui.GateMessage.Text = $Message
}

function Start-CleanRoomClosingSequence {
    $canvas = Get-UiElement -Name 'VaultCanvas'
    $script:Ui.OpenStage.Visibility = [System.Windows.Visibility]::Collapsed
    $script:Ui.ClosedStage.Visibility = [System.Windows.Visibility]::Visible
    $canvas.Visibility = [System.Windows.Visibility]::Visible

    # Clear completed opening clocks and establish the actual open pose.
    Reset-CleanRoomVaultDoor
    $script:Door.Rotate.Angle = 38
    $script:Door.Translate.X = 390
    $script:Door.Scale.ScaleX = 1
    $script:Door.Scale.ScaleY = 1
    $script:Door.Wheel.Angle = 165
    foreach ($bolt in $script:Door.Bolts) {
        $bolt.Transform.X = $bolt.DeltaX
        $bolt.Transform.Y = $bolt.DeltaY
    }
    $canvas.Opacity = 0

    $ease = [System.Windows.Media.Animation.CubicEase]::new()
    $ease.EasingMode = [System.Windows.Media.Animation.EasingMode]::EaseInOut
    $duration = [TimeSpan]::FromMilliseconds(900)
    $rotate = [System.Windows.Media.Animation.DoubleAnimation]::new(38,0,$duration)
    $translate = [System.Windows.Media.Animation.DoubleAnimation]::new(390,0,$duration)
        $fade = [System.Windows.Media.Animation.DoubleAnimation]::new(0,1,$duration)
    foreach ($animation in @($rotate,$translate,$fade)) { $animation.EasingFunction = $ease }
    $script:Door.Rotate.BeginAnimation([System.Windows.Media.RotateTransform]::AngleProperty,$rotate)
    $script:Door.Translate.BeginAnimation([System.Windows.Media.TranslateTransform]::XProperty,$translate)
    $canvas.BeginAnimation([System.Windows.UIElement]::OpacityProperty,$fade)

    $wheel = [System.Windows.Media.Animation.DoubleAnimation]::new(165,0,[TimeSpan]::FromMilliseconds(720))
    $wheel.EasingFunction = $ease
    $script:Door.Wheel.BeginAnimation([System.Windows.Media.RotateTransform]::AngleProperty,$wheel)

    foreach ($bolt in $script:Door.Bolts) {
        $x = [System.Windows.Media.Animation.DoubleAnimation]::new($bolt.DeltaX,0,[TimeSpan]::FromMilliseconds(620))
        $y = [System.Windows.Media.Animation.DoubleAnimation]::new($bolt.DeltaY,0,[TimeSpan]::FromMilliseconds(620))
        $x.EasingFunction = $ease
        $y.EasingFunction = $ease
        $bolt.Transform.BeginAnimation([System.Windows.Media.TranslateTransform]::XProperty,$x)
        $bolt.Transform.BeginAnimation([System.Windows.Media.TranslateTransform]::YProperty,$y)
    }

    if ($script:OpeningTimer) { $script:OpeningTimer.Stop() }
    $script:OpeningTimer = [System.Windows.Threading.DispatcherTimer]::new()
    $script:OpeningTimer.Interval = $duration
    $script:OpeningTimer.Add_Tick({
        $script:OpeningTimer.Stop()
        $canvas = Get-UiElement -Name 'VaultCanvas'
        Reset-CleanRoomVaultDoor
        $canvas.Visibility = [System.Windows.Visibility]::Visible
        $script:Ui.HeaderState.Text = 'SELLADA'
        $script:Ui.FooterStatus.Text = 'LOCAL · CIFRADO · SELLADA'
        $script:Ui.UnlockButton.IsEnabled = $true
        Update-EpGateMode
    })
    $script:OpeningTimer.Start()
}

function Close-EpVaultUi {
    param([string]$Reason = 'OPERATOR_LOCK')
    $wasOpen = ($script:Ui.HeaderState.Text -eq 'ABIERTA')
    if ($script:SessionTimer) { $script:SessionTimer.Stop() }
    if ($script:RevealTimer) { $script:RevealTimer.Stop() }
    if ($script:OpeningTimer) { $script:OpeningTimer.Stop() }

    # Hide sensitive surfaces and invalidate authorization before any visual movement.
    Clear-EpRevealedValue
    if (-not [System.Windows.SystemParameters]::ClientAreaAnimation) {
        if ($script:SessionTimer) { $script:SessionTimer.Stop() }
        if ($script:RevealTimer) { $script:RevealTimer.Stop() }
        $script:Ui.VariableList.ItemsSource = $null
        $script:Ui.NoteList.ItemsSource = $null
        $script:Ui.MasterPasswordBox.Clear()
        $script:Ui.ConfirmPasswordBox.Clear()
        $null = Lock-EpVault
        $script:Ui.OpenStage.Visibility = [System.Windows.Visibility]::Collapsed
        $script:Ui.ClosedStage.Visibility = [System.Windows.Visibility]::Visible
        Reset-CleanRoomVaultDoor
        (Get-UiElement -Name 'VaultCanvas').Visibility = [System.Windows.Visibility]::Visible
        $script:Ui.HeaderState.Text = 'SELLADA'
        $script:Ui.FooterStatus.Text = 'LOCAL · CIFRADO · SELLADA · MOVIMIENTO REDUCIDO · ' + $Reason
        $script:Ui.UnlockButton.IsEnabled = $true
        Update-EpGateMode
        return
    }
    $script:Ui.VariableList.ItemsSource = $null
    $script:Ui.NoteList.ItemsSource = $null
    $script:Ui.MasterPasswordBox.Clear()
    $script:Ui.ConfirmPasswordBox.Clear()
    $null = Lock-EpVault

    $script:Ui.HeaderState.Text = 'BLOQUEANDO'
    $script:Ui.FooterStatus.Text = 'SESIÓN INVALIDADA · CERRANDO CERROJOS · ' + $Reason
    $script:Ui.UnlockButton.IsEnabled = $false

    if ($wasOpen) {
        Start-CleanRoomClosingSequence
    }
    else {
        $script:Ui.OpenStage.Visibility = [System.Windows.Visibility]::Collapsed
        $script:Ui.ClosedStage.Visibility = [System.Windows.Visibility]::Visible
        Reset-CleanRoomVaultDoor
        (Get-UiElement -Name 'VaultCanvas').Visibility = [System.Windows.Visibility]::Visible
        $script:Ui.HeaderState.Text = 'SELLADA'
        $script:Ui.FooterStatus.Text = 'LOCAL · CIFRADO · SELLADA · ' + $Reason
        $script:Ui.UnlockButton.IsEnabled = $true
        Update-EpGateMode
    }
}

function Test-EpSecureStringsEqual {
    param(
        [Parameter(Mandatory=$true)][Security.SecureString]$A,
        [Parameter(Mandatory=$true)][Security.SecureString]$B
    )
    $pointerA = [IntPtr]::Zero
    $pointerB = [IntPtr]::Zero
    try {
        if ($A.Length -ne $B.Length) { return $false }
        $pointerA = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($A)
        $pointerB = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($B)
        $difference = 0
        for ($i = 0; $i -lt $A.Length; $i++) {
            $difference = $difference -bor (
                [Runtime.InteropServices.Marshal]::ReadInt16($pointerA,$i*2) -bxor
                [Runtime.InteropServices.Marshal]::ReadInt16($pointerB,$i*2)
            )
        }
        return ($difference -eq 0)
    }
    finally {
        if ($pointerA -ne [IntPtr]::Zero) { [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($pointerA) }
        if ($pointerB -ne [IntPtr]::Zero) { [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($pointerB) }
    }
}

function Update-EpGateMode {
    $status = Get-EpVaultStatus
    if ($status.vaultExists) {
        $script:Ui.GateTitle.Text = 'La cámara permanece sellada.'
        $script:Ui.GateDescription.Text = 'La autenticación local precede a cualquier movimiento del mecanismo.'
        $script:Ui.ConfirmLabel.Visibility = [System.Windows.Visibility]::Collapsed
        $script:Ui.ConfirmPasswordBox.Visibility = [System.Windows.Visibility]::Collapsed
        $script:Ui.UnlockButton.Content = 'DESBLOQUEAR LA CÁMARA'
    }
    else {
        $script:Ui.GateTitle.Text = 'La cámara aún no ha sido inicializada.'
        $script:Ui.GateDescription.Text = 'Crea una clave maestra local para sellar el primer compartimento.'
        $script:Ui.ConfirmLabel.Visibility = [System.Windows.Visibility]::Visible
        $script:Ui.ConfirmPasswordBox.Visibility = [System.Windows.Visibility]::Visible
        $script:Ui.UnlockButton.Content = 'CREAR Y SELLAR LA BÓVEDA'
    }
}

function Invoke-EpUnlock {
    $status = Get-EpVaultStatus
    $master = $script:Ui.MasterPasswordBox.SecurePassword
    $confirmation = $script:Ui.ConfirmPasswordBox.SecurePassword
    $duration = [int]$script:Ui.SessionDuration.SelectedItem.Tag
    try {
        if ($master.Length -lt 1) { throw 'MASTER_PASSWORD_EMPTY' }
        if ($status.vaultExists) {
            $null = Unlock-EpVault -Master $master -DurationSeconds $duration
        }
        else {
            if (-not (Test-EpSecureStringsEqual -A $master -B $confirmation)) {
                throw 'MASTER_PASSWORD_CONFIRMATION_MISMATCH'
            }
            $null = Initialize-EpVault -Master $master -DurationSeconds $duration
        }
        $script:Ui.MasterPasswordBox.Clear()
        $script:Ui.ConfirmPasswordBox.Clear()
        Start-CleanRoomOpeningSequence
    }
    finally {
        if ($master) { $master.Dispose() }
        if ($confirmation) { $confirmation.Dispose() }
    }
}

$script:Ui.Add_KeyDown({
    param($sender,$eventArgs)
    if ($eventArgs.Key -eq [System.Windows.Input.Key]::Escape -and $script:Ui.HeaderState.Text -eq 'ABIERTA') {
        $eventArgs.Handled = $true
        Close-EpVaultUi -Reason 'ESC_KEY_LOCK'
    }
})

$script:Ui.UnlockButton.Add_Click({
    try {
        $script:Ui.UnlockButton.IsEnabled = $false
        $script:Ui.HeaderState.Text = 'AUTENTICANDO'
        $script:Ui.FooterStatus.Text = 'VALIDANDO CLAVE LOCAL · SIN EXPONERLA EN ARGUMENTOS'
        Invoke-EpUnlock
    }
    catch {
        $script:Ui.MasterPasswordBox.Clear()
        $script:Ui.ConfirmPasswordBox.Clear()
        $script:Ui.HeaderState.Text = 'SELLADA'
        $script:Ui.FooterStatus.Text = 'AUTENTICACIÓN RECHAZADA · LA CÁMARA SIGUE CERRADA'
        Set-EpGateMessage -Message $_.Exception.Message
        [System.Windows.MessageBox]::Show(
            'No se pudo desbloquear la bóveda.' + [Environment]::NewLine + $_.Exception.Message,
            'EP Vault',
            [System.Windows.MessageBoxButton]::OK,
            [System.Windows.MessageBoxImage]::Warning
        ) | Out-Null
    }
    finally {
        $script:Ui.UnlockButton.IsEnabled = $true
    }
})

$script:Ui.LockButton.Add_Click({
    Close-EpVaultUi -Reason 'OPERATOR_LOCK'
})

$script:Ui.RefreshVariablesButton.Add_Click({
    try { Refresh-EpVariables }
    catch { [System.Windows.MessageBox]::Show($_.Exception.Message,'EP Vault') | Out-Null }
})

$script:Ui.StoreVariableButton.Add_Click({
    try {
        $name = [string]$script:Ui.VariableNameBox.Text
        if ([string]::IsNullOrWhiteSpace($name)) { throw 'VARIABLE_NAME_REQUIRED' }
        $existing = @(Get-EpVaultVariableNames)
        $replace = $false
        if ($existing -contains $name) {
            $answer = [System.Windows.MessageBox]::Show(
                'La variable ya existe. ¿Confirmas el reemplazo explícito?',
                'Confirmar reemplazo',
                [System.Windows.MessageBoxButton]::YesNo,
                [System.Windows.MessageBoxImage]::Warning
            )
            if ($answer -ne [System.Windows.MessageBoxResult]::Yes) { return }
            $replace = $true
        }
        Set-EpVaultVariableFromClipboard -Name $name -Replace:$replace | Out-Null
        $script:Ui.VariableNameBox.Clear()
        Clear-EpRevealedValue
        Refresh-EpVariables
        $script:Ui.FooterStatus.Text = 'VARIABLE GUARDADA · LECTURA DE VUELTA VERIFICADA'
    }
    catch {
        [System.Windows.MessageBox]::Show($_.Exception.Message,'No se pudo guardar') | Out-Null
    }
})

$script:Ui.RevealVariableButton.Add_Click({
    try {
        $selected = [string]$script:Ui.VariableList.SelectedItem
        if ([string]::IsNullOrWhiteSpace($selected)) { throw 'SELECT_A_VARIABLE' }
        $value = Get-EpVaultVariableValue -Name $selected -Reveal
        Show-EpRevealedValue -Value $value
        $value = $null
    }
    catch {
        [System.Windows.MessageBox]::Show($_.Exception.Message,'No se pudo revelar') | Out-Null
    }
})

$script:Ui.RemoveVariableButton.Add_Click({
    try {
        $selected = [string]$script:Ui.VariableList.SelectedItem
        if ([string]::IsNullOrWhiteSpace($selected)) { throw 'SELECT_A_VARIABLE' }
        $answer = [System.Windows.MessageBox]::Show(
            ('¿Retirar permanentemente la variable ' + $selected + ' de la bóveda?'),
            'Confirmar retirada',
            [System.Windows.MessageBoxButton]::YesNo,
            [System.Windows.MessageBoxImage]::Warning
        )
        if ($answer -ne [System.Windows.MessageBoxResult]::Yes) { return }
        Remove-EpVaultVariable -Name $selected -Approved | Out-Null
        Clear-EpRevealedValue
        Refresh-EpVariables
        $script:Ui.FooterStatus.Text = 'VARIABLE RETIRADA · AUSENCIA VERIFICADA'
    }
    catch {
        [System.Windows.MessageBox]::Show($_.Exception.Message,'No se pudo retirar') | Out-Null
    }
})

$script:Ui.CaptureNoteButton.Add_Click({
    try {
        $ttl = [int]$script:Ui.NoteTtl.SelectedItem.Tag
        $note = New-EpVaultNoteFromClipboard -TtlMinutes $ttl
        Refresh-EpNotes
        $script:Ui.FooterStatus.Text = 'NOTA EFÍMERA CAPTURADA · DPAPI CURRENT USER'
        [System.Windows.MessageBox]::Show(('Nota capturada: ' + $note.id),'EP Vault') | Out-Null
    }
    catch {
        [System.Windows.MessageBox]::Show($_.Exception.Message,'No se pudo capturar') | Out-Null
    }
})

$script:Ui.RefreshNotesButton.Add_Click({
    try { Refresh-EpNotes }
    catch { [System.Windows.MessageBox]::Show($_.Exception.Message,'EP Vault') | Out-Null }
})

$script:Ui.ReadNoteButton.Add_Click({
    try {
        $selected = $script:Ui.NoteList.SelectedItem
        if ($null -eq $selected) { throw 'SELECT_A_NOTE' }
        $note = Get-EpVaultNote -NoteId ([string]$selected.id) -Reveal
        Show-EpRevealedValue -Value $note.value
        $note = $null
    }
    catch {
        [System.Windows.MessageBox]::Show($_.Exception.Message,'No se pudo revelar la nota') | Out-Null
    }
})

$script:Ui.PromoteNoteButton.Add_Click({
    try {
        $selected = $script:Ui.NoteList.SelectedItem
        $name = [string]$script:Ui.PromoteNameBox.Text
        if ($null -eq $selected) { throw 'SELECT_A_NOTE' }
        if ([string]::IsNullOrWhiteSpace($name)) { throw 'VARIABLE_NAME_REQUIRED' }
        $replace = $false
        if (@(Get-EpVaultVariableNames) -contains $name) {
            $answer = [System.Windows.MessageBox]::Show(
                'La variable ya existe. ¿Confirmas la rotación/reemplazo?',
                'Confirmar reemplazo',
                [System.Windows.MessageBoxButton]::YesNo,
                [System.Windows.MessageBoxImage]::Warning
            )
            if ($answer -ne [System.Windows.MessageBoxResult]::Yes) { return }
            $replace = $true
        }
        Promote-EpVaultNote -NoteId ([string]$selected.id) -Name $name -Replace:$replace | Out-Null
        $script:Ui.PromoteNameBox.Clear()
        Clear-EpRevealedValue
        Refresh-EpVariables
        Refresh-EpNotes
        $script:Ui.FooterStatus.Text = 'NOTA PROMOVIDA · LECTURA DE VUELTA VERIFICADA'
    }
    catch {
        [System.Windows.MessageBox]::Show($_.Exception.Message,'No se pudo promover') | Out-Null
    }
})

$script:Ui.DeleteNoteButton.Add_Click({
    try {
        $selected = $script:Ui.NoteList.SelectedItem
        if ($null -eq $selected) { throw 'SELECT_A_NOTE' }
        $answer = [System.Windows.MessageBox]::Show(
            '¿Eliminar la nota efímera seleccionada?',
            'Confirmar eliminación',
            [System.Windows.MessageBoxButton]::YesNo,
            [System.Windows.MessageBoxImage]::Warning
        )
        if ($answer -ne [System.Windows.MessageBoxResult]::Yes) { return }
        Remove-EpVaultNote -NoteId ([string]$selected.id) -Approved | Out-Null
        Clear-EpRevealedValue
        Refresh-EpNotes
        $script:Ui.FooterStatus.Text = 'NOTA ELIMINADA · AUSENCIA VERIFICADA'
    }
    catch {
        [System.Windows.MessageBox]::Show($_.Exception.Message,'No se pudo eliminar') | Out-Null
    }
})

$script:Ui.Add_Closing({
    if (-not $script:Closing) {
        $script:Closing = $true
        if ($script:SessionTimer) { $script:SessionTimer.Stop() }
        if ($script:RevealTimer) { $script:RevealTimer.Stop() }
        if ($script:OpeningTimer) { $script:OpeningTimer.Stop() }
        Clear-EpRevealedValue
        $null = Lock-EpVault
    }
})

Build-CleanRoomVaultDoor
Update-EpGateMode
$script:Ui.Add_ContentRendered({ $script:Ui.MasterPasswordBox.Focus() | Out-Null })
$script:Ui.FooterStatus.Text = 'LOCAL · CIFRADO · SELLADA · SIN CONEXIÓN REMOTA'
$script:Ui.ShowDialog() | Out-Null
