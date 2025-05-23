# Prompt for target mining pool or server URL
$miningPoolUrl = Read-Host "Enter mining pool or URL to simulate miner traffic (e.g. http://examplepool.com/api)"

# Example list of typical crypto miner User-Agents
$minerUserAgents = @(
    "MinerGate/1.3.1",
    "XMRig/6.15.2",
    "xmrig/5.5.0",
    "ethminer/0.18.0",
    "ccminer/2.3.1"
)

# Select a random user-agent
$userAgent = Get-Random -InputObject $minerUserAgents

Write-Host "Sending simulated miner traffic to $miningPoolUrl with User-Agent: $userAgent"

try {
    # Send simple GET request with miner User-Agent header
    $response = Invoke-WebRequest -Uri $miningPoolUrl -Headers @{ "User-Agent" = $userAgent } -UseBasicParsing
    Write-Host "Response status code: $($response.StatusCode)"
} catch {
    Write-Host "Failed to send miner traffic: $_"
}
