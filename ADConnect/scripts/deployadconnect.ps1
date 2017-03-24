#
# DeployADConnect.ps1
#
# this custom will download AD Connect from microsoft, and install it on the target machine

function log
{
    param([string]$message)

    "`n`n$(get-date -f o)  $message" 

}

#check the install folder exists or not, if not, create it
$installFolder="$env:SystemDrive\ADConnect"


if(!(Test-Path -Path $installFolder )){
    New-Item -ItemType directory -Path $installFolder -Force
}

#download the scaling script to local folder
$source = "https://download.microsoft.com/download/B/0/0/B00291D0-5A83-4DE7-86F5-980BC00DE05A/AzureADConnect.msi"
$scriptFile = $installFolder+"\AzureADConnect.msi"
Invoke-WebRequest $source -OutFile $scriptFile

$cmd = "msiexec /i '$env:SystemDrive\ADConnect\AzureADConnect.msi' /qn"

log "Command to run: $cmd"

Invoke-Expression $cmd | Write-Verbose


