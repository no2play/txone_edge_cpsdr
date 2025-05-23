#!/bin/bash

echo "[*] Simulating OCSP-style traffic to trigger TXOne CPSDR rule 3010021"

read -p "Enter the target server IP (e.g., SCADA server): " TARGET

# Send GET request (simulating http-get)
curl -v http://$TARGET/oscp/ \
  -H "User-Agent: Microsoft-CryptoAPI/6.1" \
  -H "Accept: */*" \
  -H "Host: ocsp.verisign.com"

# Send POST request (simulating http-post)
curl -v -X POST http://$TARGET/oscp/a/ \
  -H "User-Agent: Microsoft-CryptoAPI/6.1" \
  -H "Accept: */*" \
  -H "Host: ocsp.verisign.com" \
  -H "Content-Type: application/octet-stream" \
  --data-binary @<(echo "YmVhY29uIG1hbGxlYWJsZSBvY3NwIHRyYWZmaWM=" | base64 -d)

echo "[+] Done. Check TXOne logs for matches on Rule ID 3010021."
