[string]$SquidPath = "./squid"
[string]$SquidPort = "3128"

function Build-Container {
    param (
        [switch]$DevBuild = $true,
        [Parameter(Mandatory = $true)]
        [string]$ContainerTag
    )

    $dockerArgs = @("--no-cache", "--tag", "$containerTag", $squidPath)
    if ($DevBuild) {
        $dockerArgs += "--build-arg"
        $dockerArgs += "dev=$Dev"
    }

    docker build @dockerArgs
}

function Start-Container {
    param (
        [string]$Port = "3128",
        [Parameter(Mandatory = $true)]
        [string]$ContainerTag,
        [string]$ContainerName
    )

    $dockerArgs = @("--rm", "-p", "${Port}:${SquidPort}", "-it")
    if ($ContainerName) {
        $dockerArgs += "--name"
        $dockerArgs += $ContainerName
    }
    $dockerArgs += $ContainerTag

    docker container run @dockerArgs
}

function Get-AccessLogs {
    param (
        [String]$AccessLogPath = "/var/log/access.log",
        [Parameter(Mandatory = $true)]
        [String]$ContainerName
    )

    $dockerArgs = @("-it", $ContainerName, "tail", "-f", $AccessLogPath)

    docker container exec $dockerArgs
}

function Get-DockerInstalled {
    try {
        $null = Get-Command docker -ErrorAction Stop

        docker version > $null
        if ($LASTEXITCODE -ne 0) {
            return $false
        }

        return $true
    }
    catch {
        return $false
    }
}   

if (-not (Get-DockerInstalled)) {
    Write-Host "Docker is not installed or not accessible"
    exit 1
}
