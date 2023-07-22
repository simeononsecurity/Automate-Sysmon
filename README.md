# Automate-Sysmon

[![VirusTotal Scan](https://github.com/simeononsecurity/Automate-Sysmon/actions/workflows/virustotal.yml/badge.svg)](https://github.com/simeononsecurity/Automate-Sysmon/actions/workflows/virustotal.yml)

## Introduction:

Increase your logging abilities to further your ability to detect threats and malicious activity on your systems.

## Recommended reading material:

- [BHIS - Getting Started With Sysmon](https://www.blackhillsinfosec.com/getting-started-with-sysmon/)
- [olafhartong/sysmon-modular](https://github.com/olafhartong/sysmon-modular)
- [Malware Archaeology Cheat Sheets](https://www.malwarearchaeology.com/cheat-sheets)

## A list of scripts and tools this collection utilizes:

- [Chocolatey](https://chocolatey.org/) - *Only if you don't already have Sysmon in your local path*
- [SwiftOnSecurity/sysmon-config](https://github.com/SwiftOnSecurity/sysmon-config)
- [Microsoft Sysinternals - Sysmon](https://docs.microsoft.com/en-us/sysinternals/downloads/sysmon)

## How to run the script

### Automated Install:
```powershell
iwr -useb 'https://simeononsecurity.ch/scripts/sosautomatesysmon.ps1'|iex
```

### Manual Install:

If manually downloaded, the script must be launched from the directory containing all the files from the [GitHub Repository](https://github.com/simeononsecurity/Automate-Sysmon)

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
Get-ChildItem -Recurse *.ps1 | Unblock-File
.\sos-automate-sysmon.ps1
```


## [Learn more about Automating Sysmon Deployments](https://simeononsecurity.ch/github/Automate-Sysmon)
<a href="https://simeononsecurity.ch" target="_blank" rel="noopener noreferrer">
  <h2>Explore the World of Cybersecurity</h2>
</a>
<a href="https://simeononsecurity.ch" target="_blank" rel="noopener noreferrer">
  <img src="https://simeononsecurity.ch/img/banner.png" alt="SimeonOnSecurity Logo" width="300" height="300">
</a>

### Links:
- #### [github.com/simeononsecurity](https://github.com/simeononsecurity)
- #### [simeononsecurity.ch](https://simeononsecurity.ch)
