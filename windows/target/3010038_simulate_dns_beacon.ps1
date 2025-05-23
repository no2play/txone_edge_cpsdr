# simulate_dns_beacon.ps1
Write-Host "[*] Simulating Cobalt Strike-style DNS beaconing..."

$domain = "examplec2.test"  # Replace with your test domain or keep as dummy
$count = 10

for ($i = 0; $i -lt $count; $i++) {
    $sub = -join ((65..90) + (97..122) | Get-Random -Count 10 | ForEach-Object {[char]$_})
    $fqdn = "$sub.$domain"

    Write-Host "Querying A record for $fqdn"
    Resolve-DnsName -Name $fqdn -Type A -Server <Your-DNS-IP> -ErrorAction SilentlyContinue

    Start-Sleep -Seconds 2
}

Write-Host "[+] Done. Check TXOne logs for Rule ID 3010038."
