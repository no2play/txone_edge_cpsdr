#!/bin/bash

echo "=== BabyShark Full CPSDR Simulation ==="

# Prompt for user input
read -p "Enter target IP (e.g., SCADA VM IP): " C2_IP
read -p "Enter secret key [default: b4bysh4rk]: " SECRET_KEY
SECRET_KEY=${SECRET_KEY:-b4bysh4rk}

read -p "Enter User-Agent [default: Mozilla/5.0...Chrome/70]: " USER_AGENT
USER_AGENT=${USER_AGENT:-"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36"}

read -p "Enter beacon interval in seconds [default: 10]: " INTERVAL
INTERVAL=${INTERVAL:-10}

echo ""
echo "[+] Creating file system artifacts..."
mkdir -p /tmp
mkfifo /tmp/input
touch /tmp/output

echo "[+] Starting BabyShark C2-like HTTP simulation to http://$C2_IP/momyshark?key=$SECRET_KEY"
echo "[+] User-Agent: $USER_AGENT"
echo "[+] Beacon interval: $INTERVAL seconds"
echo "Press CTRL+C to stop."

# Background simulation using named pipe (optional)
(
  while true; do
    echo "[+] Simulated command input" > /tmp/input
    cat /tmp/input | tr 'a-z' 'A-Z' > /tmp/output
    sleep 5
  done
) &

# Start network traffic simulation loop
while true; do
  curl -s -A "$USER_AGENT" "http://$C2_IP/momyshark?key=$SECRET_KEY" > /dev/null
  sleep "$INTERVAL"
done
