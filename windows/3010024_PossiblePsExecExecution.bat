@echo off
setlocal

:: Prompt user for target IP, username, and password
set /p TARGETIP=Enter target IP address: 
set /p USERNAME=Enter username: 
set /p PASSWORD=Enter password: 

:: Run PsExec with entered credentials and command to create test file on remote
PsExec.exe \\%TARGETIP% -u %USERNAME% -p %PASSWORD% -accepteula -nobanner cmd.exe /c "echo PsExecTest > C:\SharedTools\testfile.txt"

endlocal
pause
