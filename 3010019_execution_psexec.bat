@echo off
set /p SCADA_IP=Enter target SCADA IP: 
set /p USERNAME=Enter username: 
set /p PASSWORD=Enter password: 

REM Adjust this path to your PsExec location
SET PSEXEC_PATH=C:\Tools\PsExec.exe

echo [+] Running notepad.exe on remote target %SCADA_IP% using PsExec
%PSEXEC_PATH% \\%SCADA_IP% -u %USERNAME% -p %PASSWORD% -d notepad.exe

echo [+] Test completed
pause
