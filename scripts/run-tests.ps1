<#
.SYNOPSIS
  Runs the Cronus Fragt tests and the standard sales posting tests in a BC container (BcContainerHelper).
  NOT RUN from the repository's author environment (no Docker/Windows host); see docs/runbooks/run-tests.md.
.EXAMPLE
  ./scripts/run-tests.ps1 -AppFile ./out/Cronus_Cronus Fragt_1.2.0.0.app -TestAppFile ./out/Cronus_Cronus Fragt Tests_1.0.0.0.app
#>
param(
    [Parameter(Mandatory)][string]$AppFile,
    [Parameter(Mandatory)][string]$TestAppFile,
    [string]$ContainerName = 'crf-test',
    # Standard test codeunits that post sales documents; fill in after looking at the Test Tool page of your version.
    [Parameter(Mandatory)][string]$StandardTestCodeunits,
    [string]$ResultFolder = './testresults'
)
$ErrorActionPreference = 'Stop'
New-Item -ItemType Directory -Force $ResultFolder | Out-Null
$credential = Get-Credential -Message 'Container admin user (chosen now, not stored anywhere)'

if (-not (Get-BcContainers | Where-Object { $_ -eq $ContainerName })) {
    $artifactUrl = Get-BcArtifactUrl -type sandbox -country dk -select Latest
    New-BcContainer -accept_eula -containerName $ContainerName -credential $credential -auth UserPassword `
        -artifactUrl $artifactUrl -includeTestToolkit -updateHosts
}

# 1. Reference run: standard tests without Cronus Fragt
Run-TestsInBcContainer -containerName $ContainerName -credential $credential -testCodeunit $StandardTestCodeunits `
    -XUnitResultFileName (Join-Path $ResultFolder 'standard-without-crf.xml') -returnTrueIfAllPassed

# 2. Install Cronus Fragt and its tests
Publish-BcContainerApp -containerName $ContainerName -tenant default -install -skipVerification -sync -appFile $AppFile
Publish-BcContainerApp -containerName $ContainerName -tenant default -install -skipVerification -sync -appFile $TestAppFile

# 3. Own tests, then the same standard tests again
Run-TestsInBcContainer -containerName $ContainerName -credential $credential -testCodeunit 50140 -detailed `
    -XUnitResultFileName (Join-Path $ResultFolder 'crf-tests.xml') -returnTrueIfAllPassed
Run-TestsInBcContainer -containerName $ContainerName -credential $credential -testCodeunit $StandardTestCodeunits `
    -XUnitResultFileName (Join-Path $ResultFolder 'standard-with-crf.xml') -returnTrueIfAllPassed

Write-Host "Compare standard-without-crf.xml and standard-with-crf.xml: only failures that appear in the second file are caused by Cronus Fragt."
