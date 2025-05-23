# Prompt for raw paste service URL
$pasteUrl = Read-Host "Enter Raw Paste Service URL (e.g. https://pastebin.com/raw/xyz123)"

# Simple GET request to download raw content
try {
    Write-Host "Performing GET request to $pasteUrl ..."
    $response = Invoke-WebRequest -Uri $pasteUrl -UseBasicParsing
    Write-Host "Response received (truncated to 200 chars):"
    Write-Host $response.Content.Substring(0, [Math]::Min(200, $response.Content.Length))
} catch {
    Write-Host "GET request failed: $_"
}

# Simple POST request to upload some data (simulate paste/upload)
try {
    $postUrl = $pasteUrl # for demo, post to same URL - replace with actual POST endpoint if different
    $data = @{ content = "This is a test payload from mock SCADA at $(Get-Date)" }
    
    Write-Host "Performing POST request to $postUrl ..."
    $postResponse = Invoke-WebRequest -Uri $postUrl -Method POST -Body $data -UseBasicParsing
    Write-Host "POST response status: $($postResponse.StatusCode)"
} catch {
    Write-Host "POST request failed: $_"
}
