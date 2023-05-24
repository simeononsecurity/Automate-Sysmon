# Continue on error
$ErrorActionPreference = 'Continue'

# Require elevation for script run
#Requires -RunAsAdministrator

# Set the script location to the script root
$scriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
Set-Location -Path $scriptRoot

# Check if Sysmon.exe exists, install it if not
$sysmonPath = Get-Command -Name "Sysmon.exe" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source
if (-not $sysmonPath) {
    Write-Host "Sysmon.exe does not exist, installing.."

    # Install Chocolatey and upgrade all packages
    Start-Job -Name "Install and Configure Chocolatey" -ScriptBlock {
        Write-Host "Installing Chocolatey"
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        choco feature enable -n=allowGlobalConfirmation
        choco feature enable -n=useFipsCompliantChecksums
        choco feature enable -n=useEnhancedExitCodes
        choco config set commandExecutionTimeoutSeconds 14400
        choco config set --name="'cacheLocation'" --value="'C:\temp\chococache'"
        choco config set --name="'proxyBypassOnLocal'" --value="'true'"
        choco upgrade all
    }

    Write-Host "Sleeping for 60 Seconds While Chocolatey is Installed"
    Start-Sleep -Seconds 60
    RefreshEnv

    # Install Sysmon
    choco install sysmon -y

    # Refresh Environment to Call Sysmon.exe Natively
    RefreshEnv
}
else {
    Write-Host "Sysmon.exe exists, continuing"
}

# Download SwiftOnSecurity Sysmon Configuration
$sysmonConfigUrl = 'https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml'
$sysmonConfigLocalPath = Join-Path -Path $scriptRoot -ChildPath 'Files/sysmonconfig-export.xml'

try {
    Write-Host "Checking repo accessibility..."
    $webRequest = [System.Net.WebRequest]::Create($sysmonConfigUrl)
    $webResponse = $webRequest.GetResponse()
    $statusCode = $webResponse.StatusCode

    if ($statusCode -eq 'OK') {
        Write-Host "Repo access is available. Downloading latest Sysmon config..."
        Invoke-WebRequest -Uri $sysmonConfigUrl -OutFile $sysmonConfigLocalPath
        & $sysmonPath -u
        & $sysmonPath -accepteula -i $sysmonConfigLocalPath
    }
    else {
        Write-Host "Repo access is not available. Defaulting to the local copy."
        & $sysmonPath -u
        & $sysmonPath -accepteula -i $sysmonConfigLocalPath
    }
}
catch {
    Write-Host "Error accessing the repo. Defaulting to the local copy."
    & $sysmonPath -u
    & $sysmonPath -accepteula -i $sysmonConfigLocalPath
}
finally {
    if ($webResponse) {
        $webResponse.Close()
    }
}
