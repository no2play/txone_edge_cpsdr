@echo off
set /p KALI_IP=Enter Kali HTTP Server IP Address: 

echo [*] Simulating Suspicious User Agent traffic to %KALI_IP%

REM -- Example suspicious user agents to test
curl -A "curl/7.85.0" http://%KALI_IP%/test
curl -A "Wget/1.21.1" http://%KALI_IP%/test
curl -A "python-requests/2.27.1" http://%KALI_IP%/test
curl -A "youtube-dl/2021.06.06" http://%KALI_IP%/test

echo [*] Done. Check EdgeIPS logs for Rule ID 3010034 detection.
pause
