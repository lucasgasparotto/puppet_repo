[Net.ServicePointManager]::ServerCertificateValidationCallback = {$true};
$webClient = New-Object System.Net.WebClient;
$webClient.DownloadFile('https://puppet.classroom.puppet.com:8140/packages/current/install.ps1', 'install.ps1')
C:\windows\system32\install.ps1 "main:certname=1925win6.classroom.puppet.com"
