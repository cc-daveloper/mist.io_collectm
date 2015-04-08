[CmdletBinding()]
Param(

    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
	[string]$installerPath,

    [Parameter(Mandatory=$false)]
    [switch]$SetupConfigFile=$false,

    [Parameter(Mandatory=$false)]
	[string]$configArgs=""

)
Write-Host "Starting Installation"
Start-Process $installerPath -ArgumentList "/S" -Wait
Write-Host "Installed CollectM agent"
if ($SetupConfigFile -eq $true) {
    $installationDir = "C:\Program Files\CollectM"
    if ((Test-Path $installationDir) -eq $false) {
        $installDir = "C:\Program Files (x86)\CollectM"
        if ((Test-Path $installationDir) -eq $false) {
            Write-Host "could not locate installation directory of CollectM"
            Exit
        }
    }
    Invoke-Expression ".\collectm.config.ps1 -filePath ""$installationDir\config\default.json"" $configArgs"
}