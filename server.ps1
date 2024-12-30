param(
    [switch]$Install = $false
)

if ($PSVersionTable.PSVersion.Major -lt 7)
{
    Write-Error "This script requires Powershell >= 7."

    exit
}

if ($Install) {
    [string]$ScriptPath = $MyInvocation.MyCommand.Path
    [string]$NewServiceName = "dlproxy4"
    [string]$PowershellPath = (Get-Command "pwsh").Source
    [string]$PowershellArgs = "-ExecutionPolicy Bypass -NoProfile -File '{0}'" -f "C:\Users\zebra\projects\dlProxy\server.ps1"
    $PowershellArgs
    nssm install $NewServiceName $PowershellPath "C:\Users\zebra\projects\dlProxy\server.ps1"
    nssm status $NewServiceName

    exit
}


# Service
while ($true)
{
   Write-Output "Service is running at $(Get-Date)" | Out-File -FilePath C:\Users\zebra\projects\dlproxy.log -Append -Force -Encoding utf8
   Start-Sleep -Seconds 1
}