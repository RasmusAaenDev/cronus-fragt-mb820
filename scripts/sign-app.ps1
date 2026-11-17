<#
.SYNOPSIS
  Signs a COPY of the .app with a self-signed TEST certificate, with a time stamp, and verifies it.
  Not run from the author's environment (needs Windows and SignTool). No key or password is stored anywhere.
.EXAMPLE
  ./scripts/sign-app.ps1 -AppFile 'C:\Build\Cronus_Cronus Fragt_1.2.0.0.app'
#>
param(
    [Parameter(Mandatory)][string]$AppFile,
    [string]$TimestampUrl = 'http://timestamp.digicert.com',
    [string]$Subject = 'CN=CronusFragtTest'
)
$ErrorActionPreference = 'Stop'
$work = Join-Path ([IO.Path]::GetTempPath()) ('crf-sign-' + [guid]::NewGuid())
New-Item -ItemType Directory $work | Out-Null
try {
    $copy = Join-Path $work (Split-Path $AppFile -Leaf)
    Copy-Item $AppFile $copy
    $cert = New-SelfSignedCertificate -Type CodeSigningCert -Subject $Subject -CertStoreLocation Cert:\CurrentUser\My
    $password = Read-Host -AsSecureString -Prompt 'Password for the temporary pfx'
    $pfx = Join-Path $work 'test.pfx'
    Export-PfxCertificate -Cert $cert -FilePath $pfx -Password $password | Out-Null
    $plain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
    SignTool sign /fd SHA256 /f $pfx /p $plain /t $TimestampUrl $copy
    SignTool verify /pa /v $copy   # /pa fails for a self-signed root that is not trusted; that is expected for the test certificate
    Write-Host "Signed copy: $copy (check its Digital Signatures tab, then delete the folder $work)"
}
finally {
    Remove-Item $cert.PSPath -ErrorAction SilentlyContinue
}
