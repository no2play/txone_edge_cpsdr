#!/usr/bin/env python3

import os
import time
import requests
from pathlib import Path

print("=== BabyShark Full CPSDR Simulation (Windows Python) ===")

# Prompt for input
C2_IP = input("Enter target IP (e.g., SCADA VM IP): ").strip()
SECRET_KEY = input("Enter secret key [default: b4bysh4rk]: ").strip() or "b4bysh4rk"
USER_AGENT = input("Enter User-Agent [default: Mozilla/5.0...Chrome/70]: ").strip() or \
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36"
INTERVAL = input("Enter beacon interval in seconds [default: 10]: ").strip()
INTERVAL = int(INTERVAL) if INTERVAL.isdigit() else 10

# Windows temp paths
input_path = Path("C:/Temp/input.txt")
output_path = Path("C:/Temp/output.txt")

print("\n[+] Creating file system artifacts...")

try:
    input_path.parent.mkdir(parents=True, exist_ok=True)
    with input_path.open("w") as f:
        f.write("Simulated command input\n")
    with output_path.open("w") as f:
        f.write("")
    print(f"[+] Created: {input_path}, {output_path}")
except Exception as e:
    print(f"[!] File creation failed: {e}")
    exit(1)

print(f"[+] Starting HTTP beaconing to http://{C2_IP}/momyshark?key={SECRET_KEY}")
print(f"[+] User-Agent: {USER_AGENT}")
print(f"[+] Beacon interval: {INTERVAL} seconds")
print("Press CTRL+C to stop...\n")

try:
    while True:
        # Simulate local processing
        try:
            with input_path.open("r") as infile:
                data = infile.read()
            transformed = data.upper()
            with output_path.open("w") as outfile:
                outfile.write(transformed)
        except Exception as e:
            print(f"[!] File I/O error: {e}")

        # Simulate C2 communication
        try:
            headers = {"User-Agent": USER_AGENT}
            requests.get(f"http://{C2_IP}/momyshark?key={SECRET_KEY}", headers=headers, timeout=3)
        except requests.RequestException as e:
            print(f"[!] HTTP request error: {e}")

        time.sleep(INTERVAL)

except KeyboardInterrupt:
    print("\n[+] Stopping simulation. Cleaning up...")
    try:
        input_path.unlink()
        output_path.unlink()
        print("[+] Cleaned up artifacts.")
    except Exception as e:
        print(f"[!] Cleanup error: {e}")
