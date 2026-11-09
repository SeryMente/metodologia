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

Import-Module -Name $corePath -Force -DisableNameChecking -WarningAction SilentlyContinue -ErrorAction Stop

[xml]$xaml = Get-Content -LiteralPath $xamlPath -Raw -Encoding UTF8
$reader = [System.Xml.XmlNodeReader]::new($xaml)
$script:Ui = [System.Windows.Markup.XamlReader]::Load($reader)
$reader.Close()

# Add named XAML elements as PowerShell note properties for safe event wiring.
$uiNames = @(
    'HeaderState','SoundToggle','VaultViewport','ClosedStage','OpenStage','UnlockButton','LockButton','MasterPasswordBox',
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
$script:SharedSessionTimer = $null
$script:OpenSound = $null
$script:CloseSound = $null
$script:Closing = $false

if (-not ('EPVaultNativeWindowTheme20261108' -as [type])) {
    Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public static class EPVaultNativeWindowTheme20261108 {
    [DllImport("dwmapi.dll", PreserveSig=true)]
    private static extern int DwmSetWindowAttribute(IntPtr hwnd, int attribute, ref int value, int size);
    public static int ApplyDark(IntPtr hwnd) {
        int enabled = 1;
        int result = DwmSetWindowAttribute(hwnd, 20, ref enabled, sizeof(int));
        if (result != 0) result = DwmSetWindowAttribute(hwnd, 19, ref enabled, sizeof(int));
        return result;
    }
}
"@ -Language CSharp -ErrorAction Stop
}
function Set-EpVaultNativeDarkTitleBar {
    try {
        $helper = [System.Windows.Interop.WindowInteropHelper]::new($script:Ui)
        [void][EPVaultNativeWindowTheme20261108]::ApplyDark($helper.Handle)
    }
    catch { }
}
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
    $brush.GradientStops.Add([System.Windows.Media.GradientStop]::new([System.Windows.Media.ColorConverter]::ConvertFromString('#667276'),0.0))
    $brush.GradientStops.Add([System.Windows.Media.GradientStop]::new([System.Windows.Media.ColorConverter]::ConvertFromString('#283135'),0.22))
    $brush.GradientStops.Add([System.Windows.Media.GradientStop]::new([System.Windows.Media.ColorConverter]::ConvertFromString('#0B1013'),0.58))
    $brush.GradientStops.Add([System.Windows.Media.GradientStop]::new([System.Windows.Media.ColorConverter]::ConvertFromString('#465257'),1.0))
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
    param([double]$X1,[double]$Y1,[double]$X2,[double]$Y2,[string]$Color='#4D595D',[double]$Width=2)
    $line = [System.Windows.Shapes.Line]::new()
    $line.X1=$X1; $line.Y1=$Y1; $line.X2=$X2; $line.Y2=$Y2
    $line.Stroke = New-UiBrush -Color $Color
    $line.StrokeThickness = $Width
    $line.StrokeStartLineCap = [System.Windows.Media.PenLineCap]::Round
    $line.StrokeEndLineCap = [System.Windows.Media.PenLineCap]::Round
    [void](Get-UiElement -Name 'VaultCanvas').Children.Add($line)
    return $line
}

function Initialize-EpVaultAudio {
    $audioRoot = Join-Path (Split-Path -Parent $PSScriptRoot) 'assets\audio'
    $openPath = Join-Path $audioRoot 'Vault-Open-Creak.wav'
    $closePath = Join-Path $audioRoot 'Vault-Close-Latch.wav'
    if (Test-Path -LiteralPath $openPath -PathType Leaf) {
        $script:OpenSound = [System.Media.SoundPlayer]::new($openPath)
        $script:OpenSound.Load()
    }
    if (Test-Path -LiteralPath $closePath -PathType Leaf) {
        $script:CloseSound = [System.Media.SoundPlayer]::new($closePath)
        $script:CloseSound.Load()
    }
}
function Invoke-EpVaultAudio {
    param([Parameter(Mandatory=$true)][ValidateSet('Open','Close')][string]$Action)
    if ($null -eq $script:Ui -or $script:Ui.SoundToggle.IsChecked -ne $true) { return }
    if (-not [System.Windows.SystemParameters]::ClientAreaAnimation) { return }
    $player = if ($Action -eq 'Open') { $script:OpenSound } else { $script:CloseSound }
    if ($null -ne $player) { try { $player.Stop(); $player.Play() } catch { } }
}
function New-Ep3DMaterial {
    param([string]$Color,[string]$Specular='#A7B0B2',[double]$Power=48)
    $group=[System.Windows.Media.Media3D.MaterialGroup]::new()
    [void]$group.Children.Add([System.Windows.Media.Media3D.DiffuseMaterial]::new((New-UiBrush -Color $Color)))
    [void]$group.Children.Add([System.Windows.Media.Media3D.SpecularMaterial]::new((New-UiBrush -Color $Specular),$Power))
    return $group
}

function New-Ep3DCylinder {
    param([double]$Radius=1,[double]$Depth=0.2,$Material,[int]$Segments=48)
    $positions=[System.Windows.Media.Media3D.Point3DCollection]::new()
    $normals=[System.Windows.Media.Media3D.Vector3DCollection]::new()
    $indices=[System.Windows.Media.Int32Collection]::new()
    $half=$Depth/2.0
    for($i=0;$i -lt $Segments;$i++){
        $a=2.0*[Math]::PI*$i/$Segments
        $x=[Math]::Cos($a)*$Radius; $y=[Math]::Sin($a)*$Radius
        $n=[System.Windows.Media.Media3D.Vector3D]::new([Math]::Cos($a),[Math]::Sin($a),0)
        [void]$positions.Add([System.Windows.Media.Media3D.Point3D]::new($x,$y,-$half))
        [void]$positions.Add([System.Windows.Media.Media3D.Point3D]::new($x,$y,$half))
        [void]$normals.Add($n); [void]$normals.Add($n)
    }
    for($i=0;$i -lt $Segments;$i++){
        $a=2*$i; $b=$a+1; $c=2*(($i+1)%$Segments); $d=$c+1
        foreach($v in @($a,$c,$b,$b,$c,$d)){[void]$indices.Add($v)}
    }
    foreach($front in @($false,$true)){
        $z=if($front){$half}else{- $half}
        $normal=if($front){[System.Windows.Media.Media3D.Vector3D]::new(0,0,1)}else{[System.Windows.Media.Media3D.Vector3D]::new(0,0,-1)}
        $center=$positions.Count
        [void]$positions.Add([System.Windows.Media.Media3D.Point3D]::new(0,0,$z))
        [void]$normals.Add($normal)
        $ring=$positions.Count
        for($i=0;$i -lt $Segments;$i++){
            $a=2.0*[Math]::PI*$i/$Segments
            [void]$positions.Add([System.Windows.Media.Media3D.Point3D]::new([Math]::Cos($a)*$Radius,[Math]::Sin($a)*$Radius,$z))
            [void]$normals.Add($normal)
        }
        for($i=0;$i -lt $Segments;$i++){
            $next=($i+1)%$Segments
            if($front){foreach($v in @($center,$ring+$i,$ring+$next)){[void]$indices.Add($v)}}
            else{foreach($v in @($center,$ring+$next,$ring+$i)){[void]$indices.Add($v)}}
        }
    }
    $mesh=[System.Windows.Media.Media3D.MeshGeometry3D]::new()
    $mesh.Positions=$positions; $mesh.Normals=$normals; $mesh.TriangleIndices=$indices
    $model=[System.Windows.Media.Media3D.GeometryModel3D]::new($mesh,$Material)
    $model.BackMaterial=$Material
    return $model
}

function New-Ep3DTorus {
    param([double]$MajorRadius=1,[double]$TubeRadius=0.08,$Material,[int]$MajorSegments=72,[int]$TubeSegments=14)
    $positions=[System.Windows.Media.Media3D.Point3DCollection]::new()
    $normals=[System.Windows.Media.Media3D.Vector3DCollection]::new()
    $indices=[System.Windows.Media.Int32Collection]::new()
    for($i=0;$i -lt $MajorSegments;$i++){
        $theta=2.0*[Math]::PI*$i/$MajorSegments
        for($j=0;$j -lt $TubeSegments;$j++){
            $phi=2.0*[Math]::PI*$j/$TubeSegments
            $c=[Math]::Cos($phi); $s=[Math]::Sin($phi); $rad=$MajorRadius+$TubeRadius*$c
            [void]$positions.Add([System.Windows.Media.Media3D.Point3D]::new($rad*[Math]::Cos($theta),$rad*[Math]::Sin($theta),$TubeRadius*$s))
            [void]$normals.Add([System.Windows.Media.Media3D.Vector3D]::new($c*[Math]::Cos($theta),$c*[Math]::Sin($theta),$s))
        }
    }
    for($i=0;$i -lt $MajorSegments;$i++){
        $ni=($i+1)%$MajorSegments
        for($j=0;$j -lt $TubeSegments;$j++){
            $nj=($j+1)%$TubeSegments
            $a=$i*$TubeSegments+$j; $b=$ni*$TubeSegments+$j; $c=$ni*$TubeSegments+$nj; $d=$i*$TubeSegments+$nj
            foreach($v in @($a,$b,$d,$b,$c,$d)){[void]$indices.Add($v)}
        }
    }
    $mesh=[System.Windows.Media.Media3D.MeshGeometry3D]::new()
    $mesh.Positions=$positions; $mesh.Normals=$normals; $mesh.TriangleIndices=$indices
    $model=[System.Windows.Media.Media3D.GeometryModel3D]::new($mesh,$Material)
    $model.BackMaterial=$Material
    return $model
}

function New-Ep3DBox {
    param([double]$Width=1,[double]$Height=1,[double]$Depth=0.1,$Material)
    $x=$Width/2.0; $y=$Height/2.0; $z=$Depth/2.0
    $points=@(
        [System.Windows.Media.Media3D.Point3D]::new(-$x,-$y,-$z),[System.Windows.Media.Media3D.Point3D]::new($x,-$y,-$z),
        [System.Windows.Media.Media3D.Point3D]::new($x,$y,-$z),[System.Windows.Media.Media3D.Point3D]::new(-$x,$y,-$z),
        [System.Windows.Media.Media3D.Point3D]::new(-$x,-$y,$z),[System.Windows.Media.Media3D.Point3D]::new($x,-$y,$z),
        [System.Windows.Media.Media3D.Point3D]::new($x,$y,$z),[System.Windows.Media.Media3D.Point3D]::new(-$x,$y,$z)
    )
    $faces=@(
        @{N=[System.Windows.Media.Media3D.Vector3D]::new(0,0,1);I=@(4,5,6,7)},
        @{N=[System.Windows.Media.Media3D.Vector3D]::new(0,0,-1);I=@(1,0,3,2)},
        @{N=[System.Windows.Media.Media3D.Vector3D]::new(1,0,0);I=@(5,1,2,6)},
        @{N=[System.Windows.Media.Media3D.Vector3D]::new(-1,0,0);I=@(0,4,7,3)},
        @{N=[System.Windows.Media.Media3D.Vector3D]::new(0,1,0);I=@(7,6,2,3)},
        @{N=[System.Windows.Media.Media3D.Vector3D]::new(0,-1,0);I=@(0,1,5,4)}
    )
    $positions=[System.Windows.Media.Media3D.Point3DCollection]::new()
    $normals=[System.Windows.Media.Media3D.Vector3DCollection]::new()
    $indices=[System.Windows.Media.Int32Collection]::new()
    foreach($face in $faces){
        $offset=$positions.Count
        foreach($idx in $face.I){[void]$positions.Add($points[$idx]);[void]$normals.Add($face.N)}
        foreach($idx in @(0,1,2,0,2,3)){[void]$indices.Add($offset+$idx)}
    }
    $mesh=[System.Windows.Media.Media3D.MeshGeometry3D]::new()
    $mesh.Positions=$positions; $mesh.Normals=$normals; $mesh.TriangleIndices=$indices
    $model=[System.Windows.Media.Media3D.GeometryModel3D]::new($mesh,$Material)
    $model.BackMaterial=$Material
    return $model
}

function Set-Ep3DTranslation {
    param($Model,[double]$X,[double]$Y,[double]$Z)
    $Model.Transform=[System.Windows.Media.Media3D.TranslateTransform3D]::new($X,$Y,$Z)
}

function Build-CleanRoomVaultDoor {
    $viewport=Get-UiElement -Name 'VaultViewport'
    $canvas=Get-UiElement -Name 'VaultCanvas'
    $viewport.Children.Clear()
    $canvas.Children.Clear()
    $canvas.Visibility=[System.Windows.Visibility]::Collapsed
    $viewport.Visibility=[System.Windows.Visibility]::Visible

    $steel=New-Ep3DMaterial '#20282B' '#A8B0B2' 58
    $cast=New-Ep3DMaterial '#30383A' '#8D999C' 44
    $machined=New-Ep3DMaterial '#536065' '#D0D5D5' 78
    $dark=New-Ep3DMaterial '#0B1012' '#536065' 30
    $black=New-Ep3DMaterial '#080B0D' '#343B3E' 24
    $rubber=New-Ep3DMaterial '#111516' '#283033' 12
    $fastener=New-Ep3DMaterial '#667074' '#D9DEDE' 92
    $rust=New-Ep3DMaterial '#49372F' '#79665B' 14

    $scene=[System.Windows.Media.Media3D.Model3DGroup]::new()
    [void]$scene.Children.Add([System.Windows.Media.Media3D.AmbientLight]::new([System.Windows.Media.ColorConverter]::ConvertFromString('#303638')))
    [void]$scene.Children.Add([System.Windows.Media.Media3D.DirectionalLight]::new([System.Windows.Media.ColorConverter]::ConvertFromString('#D3D7D6'),[System.Windows.Media.Media3D.Vector3D]::new(-0.8,-1.0,-1.8)))
    [void]$scene.Children.Add([System.Windows.Media.Media3D.DirectionalLight]::new([System.Windows.Media.ColorConverter]::ConvertFromString('#7C8587'),[System.Windows.Media.Media3D.Vector3D]::new(1.1,0.35,-0.8)))

    # Structural chamber and fixed cast frame.
    $wall=New-Ep3DBox -Width 6.4 -Height 6.4 -Depth 0.42 -Material $black
    Set-Ep3DTranslation $wall 0 0 -0.72
    [void]$scene.Children.Add($wall)
    $recess=New-Ep3DCylinder -Radius 2.52 -Depth 0.24 -Material $dark -Segments 112
    Set-Ep3DTranslation $recess 0 0 -0.40
    [void]$scene.Children.Add($recess)
    $outerFlange=New-Ep3DTorus -MajorRadius 2.39 -TubeRadius 0.205 -Material $cast
    Set-Ep3DTranslation $outerFlange 0 0 -0.13
    [void]$scene.Children.Add($outerFlange)
    $innerMachined=New-Ep3DTorus -MajorRadius 2.20 -TubeRadius 0.070 -Material $machined
    Set-Ep3DTranslation $innerMachined 0 0 0.005
    [void]$scene.Children.Add($innerMachined)
    $sealBed=New-Ep3DTorus -MajorRadius 2.11 -TubeRadius 0.055 -Material $rubber
    Set-Ep3DTranslation $sealBed 0 0 0.015
    [void]$scene.Children.Add($sealBed)

    # Three substantial fixed hinge assemblies on the left jamb.
    for($h=0;$h -lt 3;$h++){
        $hy=1.42-($h*1.42)
        $plate=New-Ep3DBox -Width 0.44 -Height 0.82 -Depth 0.16 -Material $steel
        Set-Ep3DTranslation $plate -2.34 $hy -0.02
        [void]$scene.Children.Add($plate)
        $barrel=New-Ep3DCylinder -Radius 0.145 -Depth 0.76 -Material $machined -Segments 40
        $rot=[System.Windows.Media.Media3D.RotateTransform3D]::new([System.Windows.Media.Media3D.AxisAngleRotation3D]::new([System.Windows.Media.Media3D.Vector3D]::new(1,0,0),90))
        $tr=[System.Windows.Media.Media3D.TranslateTransform3D]::new(-2.24,$hy,0.16)
        $tg=[System.Windows.Media.Media3D.Transform3DGroup]::new()
        [void]$tg.Children.Add($rot); [void]$tg.Children.Add($tr)
        $barrel.Transform=$tg
        [void]$scene.Children.Add($barrel)
        $pin=New-Ep3DCylinder -Radius 0.052 -Depth 0.84 -Material $fastener -Segments 24
        $pinRot=[System.Windows.Media.Media3D.RotateTransform3D]::new([System.Windows.Media.Media3D.AxisAngleRotation3D]::new([System.Windows.Media.Media3D.Vector3D]::new(1,0,0),90))
        $pinTr=[System.Windows.Media.Media3D.TranslateTransform3D]::new(-2.24,$hy,0.16)
        $pinGroup=[System.Windows.Media.Media3D.Transform3DGroup]::new()
        [void]$pinGroup.Children.Add($pinRot); [void]$pinGroup.Children.Add($pinTr)
        $pin.Transform=$pinGroup
        [void]$scene.Children.Add($pin)
    }

    # Fixed perimeter anchor bolts.
    for($i=0;$i -lt 24;$i++){
        $a=2.0*[Math]::PI*$i/24.0
        $rivet=New-Ep3DCylinder -Radius 0.058 -Depth 0.12 -Material $fastener -Segments 20
        Set-Ep3DTranslation $rivet ([Math]::Cos($a)*2.51) ([Math]::Sin($a)*2.51) 0.005
        [void]$scene.Children.Add($rivet)
    }

    # Massive door leaf: separate thick disc, machined edges and independent face plates.
    $doorGroup=[System.Windows.Media.Media3D.Model3DGroup]::new()
    $leaf=New-Ep3DCylinder -Radius 2.08 -Depth 0.46 -Material $steel -Segments 144
    Set-Ep3DTranslation $leaf 0 0 0.16
    [void]$doorGroup.Children.Add($leaf)
    $edgeBead=New-Ep3DTorus -MajorRadius 2.015 -TubeRadius 0.115 -Material $machined
    Set-Ep3DTranslation $edgeBead 0 0 0.385
    [void]$doorGroup.Children.Add($edgeBead)
    $outerFace=New-Ep3DCylinder -Radius 1.88 -Depth 0.055 -Material $cast -Segments 128
    Set-Ep3DTranslation $outerFace 0 0 0.405
    [void]$doorGroup.Children.Add($outerFace)
    $faceRim=New-Ep3DTorus -MajorRadius 1.82 -TubeRadius 0.036 -Material $machined
    Set-Ep3DTranslation $faceRim 0 0 0.445
    [void]$doorGroup.Children.Add($faceRim)
    $innerRing=New-Ep3DTorus -MajorRadius 1.48 -TubeRadius 0.046 -Material $dark
    Set-Ep3DTranslation $innerRing 0 0 0.445
    [void]$doorGroup.Children.Add($innerRing)
    $seal=New-Ep3DTorus -MajorRadius 2.085 -TubeRadius 0.035 -Material $rubber
    Set-Ep3DTranslation $seal 0 0 0.41
    [void]$doorGroup.Children.Add($seal)

    # Machined face scoring: narrow, subdued grooves at the perimeter.
    for($i=0;$i -lt 3;$i++){
        $groove=New-Ep3DTorus -MajorRadius (1.58+$i*0.105) -TubeRadius 0.010 -Material $fastener -MajorSegments 96 -TubeSegments 8
        Set-Ep3DTranslation $groove 0 0 0.444
        [void]$doorGroup.Children.Add($groove)
    }
    for($i=0;$i -lt 16;$i++){
        $a=2.0*[Math]::PI*$i/16.0
        $mark=New-Ep3DCylinder -Radius 0.018 -Depth 0.012 -Material $rust -Segments 12
        Set-Ep3DTranslation $mark ([Math]::Cos($a)*1.74) ([Math]::Sin($a)*1.74) 0.446
        [void]$doorGroup.Children.Add($mark)
    }

    # Twelve independent radial locking bolts, each with a visible socket.
    $bolts=@()
    for($i=0;$i -lt 12;$i++){
        $a=2.0*[Math]::PI*$i/12.0
        $r=1.82; $bx=[Math]::Cos($a)*$r; $by=[Math]::Sin($a)*$r
        $socket=New-Ep3DTorus -MajorRadius 0.115 -TubeRadius 0.022 -Material $dark -MajorSegments 28 -TubeSegments 10
        Set-Ep3DTranslation $socket $bx $by 0.445
        [void]$doorGroup.Children.Add($socket)
        $bolt=New-Ep3DCylinder -Radius 0.092 -Depth 0.15 -Material $fastener -Segments 32
        $boltTr=[System.Windows.Media.Media3D.TranslateTransform3D]::new($bx,$by,0.49)
        $bolt.Transform=$boltTr
        [void]$doorGroup.Children.Add($bolt)
        $bolts+=@{Transform=$boltTr;StartX=$bx;StartY=$by;RetractedX=$bx*0.86;RetractedY=$by*0.86;Delay=320+($i*44)}
    }

    # Realistic central handwheel: ring, eight spokes, boss and shaft cap.
    $wheelGroup=[System.Windows.Media.Media3D.Model3DGroup]::new()
    $wheelRing=New-Ep3DTorus -MajorRadius 0.55 -TubeRadius 0.075 -Material $machined
    Set-Ep3DTranslation $wheelRing 0 0 0.58
    [void]$wheelGroup.Children.Add($wheelRing)
    for($i=0;$i -lt 8;$i++){
        $spoke=New-Ep3DBox -Width 0.068 -Height 1.05 -Depth 0.105 -Material $steel
        $sg=[System.Windows.Media.Media3D.Transform3DGroup]::new()
        $sr=[System.Windows.Media.Media3D.RotateTransform3D]::new([System.Windows.Media.Media3D.AxisAngleRotation3D]::new([System.Windows.Media.Media3D.Vector3D]::new(0,0,1),$i*45.0))
        $st=[System.Windows.Media.Media3D.TranslateTransform3D]::new(0,0,0.58)
        [void]$sg.Children.Add($sr); [void]$sg.Children.Add($st)
        $spoke.Transform=$sg
        [void]$wheelGroup.Children.Add($spoke)
    }
    $hub=New-Ep3DCylinder -Radius 0.22 -Depth 0.20 -Material $fastener -Segments 48
    Set-Ep3DTranslation $hub 0 0 0.60
    [void]$wheelGroup.Children.Add($hub)
    $cap=New-Ep3DCylinder -Radius 0.115 -Depth 0.22 -Material $dark -Segments 40
    Set-Ep3DTranslation $cap 0 0 0.72
    [void]$wheelGroup.Children.Add($cap)
    $wheelRotation=[System.Windows.Media.Media3D.AxisAngleRotation3D]::new([System.Windows.Media.Media3D.Vector3D]::new(0,0,1),0)
    $wheelGroup.Transform=[System.Windows.Media.Media3D.RotateTransform3D]::new($wheelRotation)
    [void]$doorGroup.Children.Add($wheelGroup)

    # Door leaf pivots independently around the left hinge line; a small axial translation releases the gasket.
    $doorRotation=[System.Windows.Media.Media3D.AxisAngleRotation3D]::new([System.Windows.Media.Media3D.Vector3D]::new(0,1,0),0)
    $doorTranslate=[System.Windows.Media.Media3D.TranslateTransform3D]::new(0,0,0)
    $doorTransform=[System.Windows.Media.Media3D.Transform3DGroup]::new()
    [void]$doorTransform.Children.Add($doorTranslate)
    [void]$doorTransform.Children.Add([System.Windows.Media.Media3D.RotateTransform3D]::new($doorRotation,-1.98,0,0.16))
    $doorGroup.Transform=$doorTransform
    [void]$scene.Children.Add($doorGroup)

    $camera=[System.Windows.Media.Media3D.PerspectiveCamera]::new()
    $camera.Position=[System.Windows.Media.Media3D.Point3D]::new(0.18,0.12,7.7)
    $camera.LookDirection=[System.Windows.Media.Media3D.Vector3D]::new(-0.18,-0.12,-7.7)
    $camera.UpDirection=[System.Windows.Media.Media3D.Vector3D]::new(0,1,0)
    $camera.FieldOfView=39
    $viewport.Camera=$camera
    $visual=[System.Windows.Media.Media3D.ModelVisual3D]::new()
    $visual.Content=$scene
    [void]$viewport.Children.Add($visual)

    $script:Door=[ordered]@{
        Bolts=$bolts; DoorRotation=$doorRotation; DoorTranslate=$doorTranslate;
        WheelRotation=$wheelRotation; OpenAngle=-72.0; OpenWheelAngle=315.0
    }
    $viewport.Focusable=$false
    $viewport.IsHitTestVisible=$false
    $viewport.Visibility=[System.Windows.Visibility]::Visible
}

function Reset-CleanRoomVaultDoor {
    if($null -eq $script:Door){return}
    $script:Door.DoorRotation.BeginAnimation([System.Windows.Media.Media3D.AxisAngleRotation3D]::AngleProperty,$null)
    $script:Door.DoorTranslate.BeginAnimation([System.Windows.Media.Media3D.TranslateTransform3D]::OffsetZProperty,$null)
    $script:Door.WheelRotation.BeginAnimation([System.Windows.Media.Media3D.AxisAngleRotation3D]::AngleProperty,$null)
    $script:Door.DoorRotation.Angle=0
    $script:Door.DoorTranslate.OffsetZ=0
    $script:Door.WheelRotation.Angle=0
    foreach($bolt in $script:Door.Bolts){
        $bolt.Transform.BeginAnimation([System.Windows.Media.Media3D.TranslateTransform3D]::OffsetXProperty,$null)
        $bolt.Transform.BeginAnimation([System.Windows.Media.Media3D.TranslateTransform3D]::OffsetYProperty,$null)
        $bolt.Transform.OffsetX=$bolt.StartX
        $bolt.Transform.OffsetY=$bolt.StartY
    }
    (Get-UiElement -Name 'VaultCanvas').Visibility=[System.Windows.Visibility]::Collapsed
    (Get-UiElement -Name 'VaultViewport').Visibility=[System.Windows.Visibility]::Visible
}

function Start-CleanRoomOpeningSequence {
    $window=$script:Ui
    $viewport=Get-UiElement -Name 'VaultViewport'
    if(-not [System.Windows.SystemParameters]::ClientAreaAnimation){
        $viewport.Visibility=[System.Windows.Visibility]::Collapsed
        $window.ClosedStage.Visibility=[System.Windows.Visibility]::Collapsed
        $window.OpenStage.Visibility=[System.Windows.Visibility]::Visible
        $window.HeaderState.Text='ABIERTA'
        $window.FooterStatus.Text='LOCAL · SESIÓN AUTENTICADA · MOVIMIENTO REDUCIDO'
        Refresh-EpVariables; Refresh-EpNotes; Update-EpSessionDisplay; Start-EpSessionTimer
        return
    }
    Invoke-EpVaultAudio -Action Open
    Reset-CleanRoomVaultDoor
    $viewport.Visibility=[System.Windows.Visibility]::Visible
    $window.OpenStage.Visibility=[System.Windows.Visibility]::Collapsed
    $window.ClosedStage.Visibility=[System.Windows.Visibility]::Visible
    $window.HeaderState.Text='DESBLOQUEANDO'
    $window.FooterStatus.Text='AUTENTICACIÓN VÁLIDA · MECANISMO MECÁNICO EN MOVIMIENTO'

    foreach($bolt in $script:Door.Bolts){
        $x=[System.Windows.Media.Animation.DoubleAnimation]::new($bolt.StartX,$bolt.RetractedX,[TimeSpan]::FromMilliseconds(900))
        $y=[System.Windows.Media.Animation.DoubleAnimation]::new($bolt.StartY,$bolt.RetractedY,[TimeSpan]::FromMilliseconds(900))
        $x.BeginTime=[TimeSpan]::FromMilliseconds($bolt.Delay); $y.BeginTime=$x.BeginTime
        $ease=[System.Windows.Media.Animation.CubicEase]::new(); $ease.EasingMode=[System.Windows.Media.Animation.EasingMode]::EaseInOut
        $x.EasingFunction=$ease; $y.EasingFunction=$ease
        $bolt.Transform.BeginAnimation([System.Windows.Media.Media3D.TranslateTransform3D]::OffsetXProperty,$x)
        $bolt.Transform.BeginAnimation([System.Windows.Media.Media3D.TranslateTransform3D]::OffsetYProperty,$y)
    }

    $wheel=[System.Windows.Media.Animation.DoubleAnimation]::new(0,$script:Door.OpenWheelAngle,[TimeSpan]::FromMilliseconds(1850))
    $wheel.BeginTime=[TimeSpan]::FromMilliseconds(900)
    $wheel.EasingFunction=[System.Windows.Media.Animation.CubicEase]::new()
    $script:Door.WheelRotation.BeginAnimation([System.Windows.Media.Media3D.AxisAngleRotation3D]::AngleProperty,$wheel)

    $release=[System.Windows.Media.Animation.DoubleAnimation]::new(0,0.12,[TimeSpan]::FromMilliseconds(380))
    $release.BeginTime=[TimeSpan]::FromMilliseconds(2550)
    $release.EasingFunction=[System.Windows.Media.Animation.CubicEase]::new()
    $script:Door.DoorTranslate.BeginAnimation([System.Windows.Media.Media3D.TranslateTransform3D]::OffsetZProperty,$release)

    $door=[System.Windows.Media.Animation.DoubleAnimation]::new(0,$script:Door.OpenAngle,[TimeSpan]::FromMilliseconds(3100))
    $door.BeginTime=[TimeSpan]::FromMilliseconds(2920)
    $door.EasingFunction=[System.Windows.Media.Animation.CubicEase]::new()
    $script:Door.DoorRotation.BeginAnimation([System.Windows.Media.Media3D.AxisAngleRotation3D]::AngleProperty,$door)

    if($script:OpeningTimer){$script:OpeningTimer.Stop()}
    $script:OpeningTimer=[System.Windows.Threading.DispatcherTimer]::new()
    $script:OpeningTimer.Interval=[TimeSpan]::FromMilliseconds(6500)
    $script:OpeningTimer.Add_Tick({
        $script:OpeningTimer.Stop()
        try{
            $null=Get-EpVaultSession
            (Get-UiElement -Name 'VaultViewport').Visibility=[System.Windows.Visibility]::Collapsed
            (Get-UiElement -Name 'ClosedStage').Visibility=[System.Windows.Visibility]::Collapsed
            (Get-UiElement -Name 'OpenStage').Visibility=[System.Windows.Visibility]::Visible
            $script:Ui.HeaderState.Text='ABIERTA'
            $script:Ui.FooterStatus.Text='LOCAL · SESIÓN AUTENTICADA · TTL ABSOLUTO'
            Refresh-EpVariables; Refresh-EpNotes; Update-EpSessionDisplay; Start-EpSessionTimer
        }catch{
            Close-EpVaultUi -Reason 'SESSION_INVALID_AFTER_OPEN'
            Set-EpGateMessage -Message $_.Exception.Message
        }
    })
    $script:OpeningTimer.Start()
}

function Start-CleanRoomClosingSequence {
    Invoke-EpVaultAudio -Action Close
    $viewport=Get-UiElement -Name 'VaultViewport'
    $script:Ui.OpenStage.Visibility=[System.Windows.Visibility]::Collapsed
    $script:Ui.ClosedStage.Visibility=[System.Windows.Visibility]::Visible
    $viewport.Visibility=[System.Windows.Visibility]::Visible
    Reset-CleanRoomVaultDoor
    $script:Door.DoorRotation.Angle=$script:Door.OpenAngle
    $script:Door.DoorTranslate.OffsetZ=0.12
    $script:Door.WheelRotation.Angle=$script:Door.OpenWheelAngle
    foreach($bolt in $script:Door.Bolts){
        $bolt.Transform.OffsetX=$bolt.RetractedX
        $bolt.Transform.OffsetY=$bolt.RetractedY
    }

    $ease=[System.Windows.Media.Animation.CubicEase]::new()
    $ease.EasingMode=[System.Windows.Media.Animation.EasingMode]::EaseInOut
    $door=[System.Windows.Media.Animation.DoubleAnimation]::new($script:Door.OpenAngle,0,[TimeSpan]::FromMilliseconds(3200))
    $door.EasingFunction=$ease
    $script:Door.DoorRotation.BeginAnimation([System.Windows.Media.Media3D.AxisAngleRotation3D]::AngleProperty,$door)

    $release=[System.Windows.Media.Animation.DoubleAnimation]::new(0.12,0,[TimeSpan]::FromMilliseconds(320))
    $release.BeginTime=[TimeSpan]::FromMilliseconds(2880)
    $release.EasingFunction=$ease
    $script:Door.DoorTranslate.BeginAnimation([System.Windows.Media.Media3D.TranslateTransform3D]::OffsetZProperty,$release)

    $wheel=[System.Windows.Media.Animation.DoubleAnimation]::new($script:Door.OpenWheelAngle,0,[TimeSpan]::FromMilliseconds(1750))
    $wheel.BeginTime=[TimeSpan]::FromMilliseconds(420)
    $wheel.EasingFunction=$ease
    $script:Door.WheelRotation.BeginAnimation([System.Windows.Media.Media3D.AxisAngleRotation3D]::AngleProperty,$wheel)

    foreach($bolt in $script:Door.Bolts){
        $x=[System.Windows.Media.Animation.DoubleAnimation]::new($bolt.RetractedX,$bolt.StartX,[TimeSpan]::FromMilliseconds(820))
        $y=[System.Windows.Media.Animation.DoubleAnimation]::new($bolt.RetractedY,$bolt.StartY,[TimeSpan]::FromMilliseconds(820))
        $x.BeginTime=[TimeSpan]::FromMilliseconds(2200); $y.BeginTime=$x.BeginTime
        $x.EasingFunction=$ease; $y.EasingFunction=$ease
        $bolt.Transform.BeginAnimation([System.Windows.Media.Media3D.TranslateTransform3D]::OffsetXProperty,$x)
        $bolt.Transform.BeginAnimation([System.Windows.Media.Media3D.TranslateTransform3D]::OffsetYProperty,$y)
    }

    if($script:OpeningTimer){$script:OpeningTimer.Stop()}
    $script:OpeningTimer=[System.Windows.Threading.DispatcherTimer]::new()
    $script:OpeningTimer.Interval=[TimeSpan]::FromMilliseconds(3900)
    $script:OpeningTimer.Add_Tick({
        $script:OpeningTimer.Stop()
        Reset-CleanRoomVaultDoor
        $script:Ui.HeaderState.Text='SELLADA'
        $script:Ui.FooterStatus.Text='LOCAL · CIFRADO · SELLADA'
        $script:Ui.UnlockButton.IsEnabled=$true
        Update-EpGateMode
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

function Start-EpSharedSessionMonitor {
    if ($script:SharedSessionTimer) { $script:SharedSessionTimer.Stop() }
    $script:SharedSessionTimer = [System.Windows.Threading.DispatcherTimer]::new()
    $script:SharedSessionTimer.Interval = [TimeSpan]::FromSeconds(1)
    $script:SharedSessionTimer.Add_Tick({
        $active = $false
        try {
            $null = Get-EpVaultSession
            $active = $true
        }
        catch {
            $active = $false
        }
        $state = [string]$script:Ui.HeaderState.Text
        if ($active -and $state -eq 'SELLADA') {
            Start-CleanRoomOpeningSequence
        }
        elseif ($active -and $state -eq 'ABIERTA') {
            try { Update-EpSessionDisplay }
            catch { Close-EpVaultUi -Reason 'SHARED_SESSION_INVALID' }
        }
        elseif (-not $active -and $state -eq 'ABIERTA') {
            Close-EpVaultUi -Reason 'SHARED_SESSION_REVOKED'
        }
    })
    $script:SharedSessionTimer.Start()
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
        $script:Ui.SessionRemaining.Foreground = New-UiBrush -Color '#B16E49'
    }
    else {
        $script:Ui.SessionRemaining.Foreground = New-UiBrush -Color '#A66D49'
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

$script:Ui.Add_SourceInitialized({ Set-EpVaultNativeDarkTitleBar })
$script:Ui.Add_Closing({
    if (-not $script:Closing) {
        $script:Closing = $true
        if ($script:SessionTimer) { $script:SessionTimer.Stop() }
        if ($script:RevealTimer) { $script:RevealTimer.Stop() }
        if ($script:OpeningTimer) { $script:OpeningTimer.Stop() }
        if ($script:SharedSessionTimer) { $script:SharedSessionTimer.Stop() }
        Clear-EpRevealedValue
        $null = Lock-EpVault
    }
})

Build-CleanRoomVaultDoor
Update-EpGateMode
$script:Ui.Add_ContentRendered({
    try {
        $null = Get-EpVaultSession
        Start-CleanRoomOpeningSequence
    }
    catch {
        $script:Ui.MasterPasswordBox.Focus() | Out-Null
    }
})
Start-EpSharedSessionMonitor
$script:Ui.FooterStatus.Text = 'LOCAL · CIFRADO · SELLADA · SIN CONEXIÓN REMOTA'
$script:Ui.ShowDialog() | Out-Null