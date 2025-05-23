@echo off
echo [*] Simulating communication to ngrok tunneling service...

REM Send HTTP GET to ngrok.io
curl -A "Mozilla/5.0" https://ngrok.io

REM You can add more known subdomains if needed
curl -A "Mozilla/5.0" https://dashboard.ngrok.com
curl -A "Mozilla/5.0" https://api.ngrok.com

echo [*] Done. Check TXOne logs for detection of Rule ID 3010037.
pause
