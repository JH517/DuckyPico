# Define the trigger (every 4 hours)
$Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1) -RepetitionInterval (New-TimeSpan -Hours 4) -RepetitionDuration (New-TimeSpan -Days 1)

# Define the action (PowerShell command to run)
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -Command `"Start-Process chrome.exe '--new-window https://sharepointmaven.com/wp-content/uploads/2022/09/brandloginwindowmicrosoft3651.jpg' -WindowStyle Normal`""

# Define the task settings (task configuration)
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable

# Register the task
Register-ScheduledTask -TaskName "OpenChromeEvery4Hours" -Action $Action -Trigger $Trigger -Settings $Settings -Description "Opens Chrome to the specified URL every 4 hours."
