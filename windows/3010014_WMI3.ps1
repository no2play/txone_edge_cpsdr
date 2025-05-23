$remoteComputer = "<SCADA_IP>"
$process = "notepad.exe"
$cred = Get-Credential

Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{CommandLine = $process} -ComputerName $remoteComputer -Credential $cred
