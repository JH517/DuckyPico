# Define encryption details
$password = "pass1234"
$key = (New-Object System.Security.Cryptography.SHA256Managed).ComputeHash([System.Text.Encoding]::UTF8.GetBytes($password))
$downloadsPath = [environment]::GetFolderPath("UserProfile") + "\Downloads\test"

# Encrypt function
function Encrypt-File {
    param (
        [string]$FilePath,
        [byte[]]$Key
    )
    $outputFile = "$FilePath.enc"
    $aes = [System.Security.Cryptography.Aes]::Create()
    $aes.Key = $Key
    $aes.GenerateIV()

    $ivFile = $FilePath + ".iv"
    [IO.File]::WriteAllBytes()
}
