#
# DeployScalingScript.ps1
#
param(
    [parameter(mandatory = $true)][ValidateNotNullOrEmpty()] [string]$taskName,

    [parameter(mandatory = $true)][ValidateNotNullOrEmpty()] [int]$taskInterval,

    [parameter(mandatory = $true)][ValidateNotNullOrEmpty()] [string]$taskExecutionAccountUserName,

    [parameter(mandatory = $true)][ValidateNotNullOrEmpty()] [string]$taskExecutionAccountPassword,

    [parameter(mandatory = $true)][ValidateNotNullOrEmpty()] [string]$folderName,

    [parameter(mandatory = $true)][ValidateNotNullOrEmpty()] [string]$scriptLocation,

    [string]$scriptLocationSastoken
)

function log
{
    param([string]$message)

    "`n`n$(get-date -f o)  $message" 

}

#check the install folder exists or not, if not, create it
$installFolder="c:\"+$folderName

$scriptLocationSastoken="?sv=2015-04-05&sr=c&sig=OQUo5mv6jgSxWvQpYDDVMCmX5w6gwawfpncVOjQSE%2F4%3D&se=2017-01-17T02%3A09%3A44Z&sp=r"

if(!(Test-Path -Path $installFolder )){
    New-Item -ItemType directory -Path $installFolder -Force
}

#download the scaling script to local folder
$source = $scriptLocation + "/RDSScaler.ps1" + $scriptLocationSastoken
$scriptFile = $installFolder+"\RDSScaler.ps1"
Invoke-WebRequest $source -OutFile $scriptFile

$source = $scriptLocation + "/Config.xml" + $scriptLocationSastoken
$configFile = $installFolder+"\Config.xml"
Invoke-WebRequest $source -OutFile $configFile

#check the azure powershel module exists or not, if not, install it

if (-not (get-module -ListAvailable -Name AzureRM))
{
    log "installing AzureRm powershell module..."
    
    install-module AzureRM -force

}

#create the scheduled task
$currentTask = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue

if($currentTask -ne $null)
{
    log "removing existing task"

    Unregister-ScheduledTask -TaskName $taskName -Confirm: $false

}

$action = New-ScheduledTaskAction –Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File $($scriptFile)" -WorkingDirectory ([IO.Path]::GetDirectoryName($scriptFile))

$trigger = New-ScheduledTaskTrigger -once -at 0am -RepetitionInterval (new-timespan -minutes $taskInterval)

Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -User $taskExecutionAccountUserName -Password $taskExecutionAccountPassword -Description $taskName

Start-ScheduledTask -TaskName $taskName
