#!/bin/bash

echo "=== BabyShark CPSDR Simulation Script ==="

# Prompt for input values
read -p "Enter target IP (e.g., SCADA VM IP): " C2_IP
read -p "Enter secret key [default: b4bysh4rk]: " SECRET_KEY
SECRET_KEY=${SECRET_KEY:-b4bysh4rk}

read -p "Enter User-Agent string [default: BabyShark User-Agent]: " USER_AGENT
USER_AGENT=${USER_AGENT:-"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36"}

read -p "Enter beacon interval in seconds [default: 10]: " INTERVAL
INTERVAL=${INTERVAL:-10}

echo ""
echo "[+] Starting BabyShark traffic simulation to http://$C2_IP/momyshark?key=$SECRET_KEY"
echo "[+] Using User-Agent: $USER_AGENT"
echo "[+] Beacon interval: $INTERVAL seconds"
echo "Press CTRL+C to stop..."

# Begin traffic simulation loop
while true; do
  curl -s -A "$USER_AGENT" "http://$C2_IP/momyshark?key=$SECRET_KEY" > /dev/null
  sleep "$INTERVAL"
done
