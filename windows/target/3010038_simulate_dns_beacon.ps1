Write-Host "[*] Simulating Cobalt Strike-style DNS beaconing with TXT queries..."

$domain = "c2beacon.local"  # Use internal test domain or mimic a C2-style FQDN
$dnsServer = "192.168.1.1"  # Change to your DNS server IP
$count = 15

for ($i = 0; $i -lt $count; $i++) {
    $sub = -join ((48..57)+(65..90)+(97..122) | Get-Random -Count 20 | ForEach-Object {[char]$_})
    $fqdn = "$sub.$domain"

    Write-Host "Querying TXT record for $fqdn"
    Resolve-DnsName -Name $fqdn -Type TXT -Server $dnsServer -ErrorAction SilentlyContinue

    Start-Sleep -Seconds 3
}

Write-Host "[+] Finished beacon simulation. Check for Rule ID 3010038."
