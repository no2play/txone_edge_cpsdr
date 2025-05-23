$remoteComputer = "<SCADA_IP>"
$process = "notepad.exe"

# Prompt for credentials
$cred = Get-Credential

Invoke-WmiMethod -Class Win32_Process -Name Create -ArgumentList $process -ComputerName $remoteComputer -Credential $cred
