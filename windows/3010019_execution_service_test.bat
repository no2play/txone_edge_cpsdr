@echo off
set /p SCADA_IP=Enter target SCADA IP: 
SET SERVICE_NAME=TestSvc
SET BINARY_PATH="C:\Windows\System32\notepad.exe"

echo [+] Creating service on %SCADA_IP%
sc \\%SCADA_IP% create %SERVICE_NAME% binPath= %BINARY_PATH%

echo [+] Starting service on %SCADA_IP%
sc \\%SCADA_IP% start %SERVICE_NAME%

timeout /t 10

echo [+] Deleting service...
sc \\%SCADA_IP% delete %SERVICE_NAME%

echo [+] Test completed
pause
