#Continue on error
$ErrorActionPreference = 'silentlycontinue'

#Require elivation for script run
#Requires -RunAsAdministrator

$command = "Sysmon.exe"
if ((((Get-Command $command).Source) | Test-Path) -ne $true) {
    Write-Host "$command does not exist, installing.."
    Start-Job -Name "Install and Configure Chocolatey" -ScriptBlock {
        Write-Host "Installing Chocolatey"
        # Setting up directories for values
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
    Sleep 60
    refreshenv
    # Install Sysmon
    choco install sysmon
    # Refresh Environment to Call Sysmon.exe Natively
    refreshenv
}
Else {
    Write-Host "$command exists, continuing"
}

# Download SwiftOnSecurity Sysmon Configuration
# Test if web access to the repo is available, if so download latest version of config
# First we create the request.
$HTTP_Request = [System.Net.WebRequest]::Create('https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml')
# We then get a response from the site.
$HTTP_Response = $HTTP_Request.GetResponse()
# We then get the HTTP code as an integer.
$HTTP_Status = [int]$HTTP_Response.StatusCode
If ($HTTP_Status -eq 200) {
    Write-Host "Repo Access is Available. Downloading Latest Sysmon Config"
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml" -OutFile ./Files/sysmonconfig-export.xml
    sysmon.exe -u
    sysmon.exe -accepteula -i ./Files/sysmonconfig-export.xml
}
Else {
    Write-Host "Repo Access is Not Available. Defaulting to the local copy."
    sysmon.exe -u
    sysmon.exe -accepteula -i ./Files/sysmonconfig-export.xml
}
# Finally, we clean up the http request by closing it.
If ($HTTP_Response -eq $null) { } 
Else { $HTTP_Response.Close() }

