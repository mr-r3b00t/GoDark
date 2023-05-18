#BYE BYE CHARLIE FREN
#DNS Client Sinkhole - this isn't fully working

Get-DnsClientNrptRule | Remove-DnsClientNrptRule -Force

$domainlist = Get-Content .\domains.txt

foreach($namespace in $domainlist){

Add-DnsClientNrptRule -Namespace $namespace -NameServers "127.0.0.2"

}

Get-DnsClientNrptRule

ipconfig /flushdns

stop-Service -Name DiagTrack
Stop-Service -Name CDPSvc
Stop-Service -Name wuauserv
Stop-Service -Name WaaSMedicSvc

Set-Service -Name DiagTrack -StartupType Disabled
Set-Service -Name CDPSvc -StartupType Disabled
Set-Service -Name wuauserv -StartupType Disabled
Set-Service -Name WaaSMedicSvc -StartupType Disabled

#Disable Windows Update
New-Item HKLM:\SOFTWARE\Policies\Microsoft\Windows -Name WindowsUpdate
New-Item HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate -Name AU
New-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -Name NoAutoUpdate -Value 1

Get-ScheduledTask -TaskName *defender* | Disable-ScheduledTask

Get-ScheduledTask -TaskName QueueReporting  | Disable-ScheduledTask

Get-ScheduledTask -TaskName Consolidator | Disable-ScheduledTask
Get-ScheduledTask -TaskName UsbCeip | Disable-ScheduledTask
Get-ScheduledTask -TaskName Microsoft-Windows-DiskDiagnosticDataCollector | Disable-ScheduledTask
Get-ScheduledTask -TaskName "Scheduled Start" | Disable-ScheduledTask

Set-MpPreference -DisableArchiveScanning 1 -ErrorAction SilentlyContinue
Set-MpPreference -DisableBehaviorMonitoring 1 -ErrorAction SilentlyContinue
Set-MpPreference -DisableIntrusionPreventionSystem 1 -ErrorAction SilentlyContinue
Set-MpPreference -DisableIOAVProtection 1 -ErrorAction SilentlyContinue
Set-MpPreference -DisableRemovableDriveScanning 1 -ErrorAction SilentlyContinue
Set-MpPreference -DisableBlockAtFirstSeen 1 -ErrorAction SilentlyContinue
Set-MpPreference -DisableScanningMappedNetworkDrivesForFullScan 1 -ErrorAction SilentlyContinue
Set-MpPreference -DisableScanningNetworkFiles 1 -ErrorAction SilentlyContinue
Set-MpPreference -DisableScriptScanning 1 -ErrorAction SilentlyContinue
Set-MpPreference -DisableRealtimeMonitoring 1 -ErrorAction SilentlyContinue
Set-MpPreference -MAPSReporting Disabled -ErrorAction SilentlyContinue
Set-MpPreference -SubmitSamplesConsent 2 -ErrorAction SilentlyContinue
