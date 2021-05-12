# Automate-Sysmon

## Introduction:

Increase your logging abilities to further your ability to detect threats and malicious activity on your systems.

## Recommended reading material:

- [BHIS - Getting Started With Sysmon](https://www.blackhillsinfosec.com/getting-started-with-sysmon/)
- [olafhartong/sysmon-modular](https://github.com/olafhartong/sysmon-modular)
- [Malware Archaeology Cheat Sheets](https://www.malwarearchaeology.com/cheat-sheets)

## A list of scripts and tools this collection utilizes:

- [SwiftOnSecurity/sysmon-config](https://github.com/SwiftOnSecurity/sysmon-config)
- [Microsoft Sysinternals - Sysmon](https://docs.microsoft.com/en-us/sysinternals/downloads/sysmon)

## How to run the script

### Manual Install:

If manually downloaded, the script must be launched from the directory containing all the files from the [GitHub Repository](https://github.com/simeononsecurity/Automate-Sysmon)

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
Get-ChildItem -Recurse *.ps1 | Unblock-File
.\sos-automate-sysmon.ps1
```