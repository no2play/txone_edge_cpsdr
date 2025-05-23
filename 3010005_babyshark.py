#!/usr/bin/env python3

import os
import time
import requests

print("=== BabyShark Full CPSDR Simulation (Python) ===")

# Prompt for input
C2_IP = input("Enter target IP (e.g., SCADA VM IP): ").strip()
SECRET_KEY = input("Enter secret key [default: b4bysh4rk]: ").strip() or "b4bysh4rk"
USER_AGENT = input("Enter User-Agent [default: Mozilla/5.0...Chrome/70]: ").strip() or \
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36"
INTERVAL = input("Enter beacon interval in seconds [default: 10]: ").strip()
INTERVAL = int(INTERVAL) if INTERVAL.isdigit() else 10

print("\n[+] Creating file system artifacts...")
input_path = "/tmp/input"
output_path = "/tmp/output"

try:
    # Create input/output files
    with open(input_path, "w") as f:
        f.write("Simulated command input\n")
    with open(output_path, "w") as f:
        f.write("")
    print(f"[+] Created: {input_path}, {output_path}")
except Exception as e:
    print(f"[!] File creation failed: {e}")
    exit(1)

print(f"[+] Starting HTTP beaconing to http://{C2_IP}/momyshark?key={SECRET_KEY}")
print(f"[+] User-Agent: {USER_AGENT}")
print(f"[+] Beacon interval: {INTERVAL} seconds")
print("Press CTRL+C to stop...\n")

# Simulated main loop
try:
    while True:
        # Simulate local processing
        try:
            with open(input_path, "r") as infile:
                data = infile.read()
            transformed = data.upper()
            with open(output_path, "w") as outfile:
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

    # Optional cleanup
    try:
        os.remove(input_path)
        os.remove(output_path)
        print("[+] Cleaned up artifacts.")
    except Exception as e:
        print(f"[!] Cleanup error: {e}")
