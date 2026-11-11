# EP Vault 1.0.1 — Session MVP

**Status:** pre-release MVP; remote B2 checkpoint blocked until the portable EP Application Key secret is present in EP Vault. Not production-accepted.

## Added in 1.0.1
- Separate VHDX workspace container with NTFS and BitLocker XTS-AES-256.
- Random per-session BitLocker password and recovery password stored as named entries in EP Vault.
- Desktop junction to workspace mounted inside the VHDX.
- Restore/mount of a sealed local VHDX.
- Manual save-and-close path: B2 upload + download/readback before local removal.
- Idle guardian: 10 minutes of inactivity, 60-second polling/heartbeat, absolute 8-hour limit.
- Emergency crypto-erasure path, explicitly destructive and not a backup operation.

## Required gates
- PowerShell 5.1; administrative session; BitLocker cmdlets; EP Vault unlocked.
- EP Vault must contain EP_B2_BUCKET_NAME=OCP-MCP, EP_B2_PREFIX=ep-ocp/, EP_B2_APPLICATION_KEY_ID, and EP_B2_APPLICATION_KEY.
- The current PC-8 Vault snapshot has the key ID but does not contain EP_B2_APPLICATION_KEY; no B2 upload can be accepted until the missing secret is provisioned by the operator.
- The 1.0.1 MVP has not passed physical VHDX/BitLocker E2E, remote B2 readback, or cross-device restore. It is not installed over or merged into 1.0.0.

## Explicit limits
- Does not redirect all application AppData yet. Only the EP workspace path is inside the VHDX; unrelated Windows/app profiles are not swept or deleted.
- The emergency close can destroy the only local copy if used without a verified checkpoint.
- Delete-Item/NTFS removal is not forensic sanitization on SSDs. Crypto-erasure depends on destroying all recoverable keys; no forensic guarantee is claimed.
- Source Desktop\SeryMente and the R4 ZIP remain intact until an encrypted backup is verified and the operator authorizes cleanup.

## Intended destination
Backblaze bucket OCP-MCP, prefix ep-ocp/workspace-sessions/. B2 objects must remain encrypted VHDX ciphertext. Never upload plaintext workspace or plaintext key material.