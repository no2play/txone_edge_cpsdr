import os
import re
import time
import requests
import base64
from datetime import datetime

PROFILE_DIR = "/home/kali/Malleable-C2-Profiles"  # Update if needed https://github.com/BC-SECURITY/Malleable-C2-Profiles
TARGET_IP = "192.168.1.101"  # ← CHANGE to your SCADA IP
LOG_FILE = "cpsdr_test_log.txt"
BEACON_COUNT = 2
BEACON_INTERVAL = 5

def list_profiles():
    profiles = []
    for root, _, files in os.walk(PROFILE_DIR):
        for f in files:
            if f.endswith(".profile"):
                profiles.append(os.path.join(root, f))
    return profiles

def parse_profile(filepath):
    with open(filepath, 'r', errors="ignore") as f:
        content = f.read()

    user_agent = re.search(r'set useragent\s+"(.+?)"', content)
    user_agent = user_agent.group(1) if user_agent else "Mozilla/5.0"

    uri_match = re.search(r'http-get\s*{[^}]*?set uri\s+"(.+?)"', content, re.DOTALL)
    uri = uri_match.group(1) if uri_match else "/"

    headers = {}
    header_matches = re.findall(r'header\s+"(.+?)"\s+"(.+?)"', content)
    for k, v in header_matches:
        headers[k] = v

    return {
        "useragent": user_agent,
        "uri": uri,
        "headers": headers
    }

def generate_payload():
    command = "whoami"
    return base64.b64encode(command.encode()).decode()

def simulate_beacon(profile_name, profile_data):
    url = f"http://{TARGET_IP}{profile_data['uri']}"
    headers = profile_data["headers"]
    headers["User-Agent"] = profile_data["useragent"]
    headers.setdefault("Accept", "*/*")

    success = False
    for _ in range(BEACON_COUNT):
        payload = generate_payload()
        try:
            response = requests.post(url, headers=headers, data={"data": payload}, timeout=5)
            success = True
        except Exception as e:
            log(f"[{profile_name}] Error: {e}")
        time.sleep(BEACON_INTERVAL)
    return success

def log(msg):
    with open(LOG_FILE, "a") as f:
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        f.write(f"[{timestamp}] {msg}\n")
    print(msg)

def main():
    profiles = list_profiles()
    if not profiles:
        print("[-] No profiles found.")
        return

    log("\n========== CPSDR Auto-Test Start ==========\n")
    log(f"Target: {TARGET_IP} | Total Profiles: {len(profiles)}")

    for i, profile_path in enumerate(profiles, start=1):
        profile_name = os.path.basename(profile_path)
        log(f"\n[{i}/{len(profiles)}] Testing: {profile_name}")

        try:
            profile_data = parse_profile(profile_path)
            simulate_beacon(profile_name, profile_data)
            log(f"[{profile_name}] Beacon sent.")
        except Exception as e:
            log(f"[{profile_name}] Failed to process: {e}")

    log("\n========== CPSDR Auto-Test Complete ==========\n")

if __name__ == "__main__":
    main()
