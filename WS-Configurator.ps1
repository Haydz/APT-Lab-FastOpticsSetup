cd \\dc01\labs\sysmon\
./sysmon64.exe -accepteula -i sysmonconfig.xml
Get-WinEvent -LogName Microsoft-Windows-Sysmon/Operational
#add full auditpol.exe
auditpol.exe /set /category:* /sucess:enable
auditpol.exe /set /category:* /failure:enable
Set-Itemproperty -path "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Value 1
#Enable PowerShell ScriptBlock logging & Module Logging
#Add PowerShell folder for policies   
New-Item –Path  "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "PowerShell"
#EnablePowerShell ScriptBlockLogging
New-Item –Path  "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell" -Name "ScriptBlockLogging"
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Name "EnableScriptBlockLogging " -Value 1 -PropertyType "DWORD"
#Add PowerShell Module logging, set to ALL
New-Item –Path  "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell" -Name "ModuleLogging"
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging" -Name "EnableModuleLogging" -Value 1 -PropertyType "DWORD"
New-Item –Path  "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging" -Name "ModuleNames"
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging\ModuleNames" -Name "*" -Value "*" -PropertyType "String"
gpupdate /force
Restart-Computer
