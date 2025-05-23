$SCADA_IP = Read-Host "Enter target SCADA IP"
$ServiceName = "TestSvc"
$BinPath = "C:\Windows\System32\notepad.exe"

Write-Output "[+] Creating remote service on $SCADA_IP..."
Invoke-Command -ComputerName $SCADA_IP -ScriptBlock {
    param($ServiceName, $BinPath)
    sc.exe create $ServiceName binPath= $BinPath
} -ArgumentList $ServiceName, $BinPath

Start-Sleep -Seconds 3

Write-Output "[+] Starting service..."
Invoke-Command -ComputerName $SCADA_IP -ScriptBlock {
    param($ServiceName)
    sc.exe start $ServiceName
} -ArgumentList $ServiceName

Start-Sleep -Seconds 10

Write-Output "[+] Deleting service..."
Invoke-Command -ComputerName $SCADA_IP -ScriptBlock {
    param($ServiceName)
    sc.exe delete $ServiceName
} -ArgumentList $ServiceName

Write-Output "[+] Test complete"
