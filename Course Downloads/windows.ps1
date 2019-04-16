
# Setup the MOTD info
Write-output "Updating the MOTD Info..."

$registryPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\policies\system"
New-ItemProperty -Path $registryPath -Name 'legalnoticecaption' -Value 'Welcome to class!' -PropertyType String -Force | out-null

$registryPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\policies\system"
New-ItemProperty -Path $registryPath -Name 'legalnoticetext' -Value 'You are about to login to a Puppet Classroom Windows Server' -PropertyType String -Force | out-null

write-output "MOTD Set successfully!"


# Config NTP
write-output "Configure Time server..."
w32tm /config /manualpeerlist:pool.ntp.org /syncfromflags:MANUAL
stop-service w32time
start-service w32time
w32tm /resync
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers"
New-ItemProperty -Path $registryPath -Name '1' -Value 'pool.ntp.org' -PropertyType String -Force | out-null
write-output "Time server set correctly!"


# Generate an Inventory Report
write-output ""
write-output "Inventory report:"
$hostname = hostname
$ip = (Get-NetIPConfiguration).IPv4Address.IPAddress
$os = (Get-WmiObject Win32_OperatingSystem).Caption

$size = (Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'").Size
$used = ($size - (Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'").FreeSpace)
$p_used = [math]::Round(($used/$size)*100,2)

$rpt = new-object psobject
$rpt | add-member -NotePropertyName  "Hostname" -notepropertyvalue $hostname
$rpt | add-member -NotePropertyName   "IPAddress" -notepropertyvalue $ip
$rpt | add-member -NotePropertyName  "OSName" -notepropertyvalue $os
$rpt | add-member -NotePropertyName  "DiskUsed" -notepropertyvalue $p_used

Write-Output $rpt



