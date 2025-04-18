New-LocalUser -Name "duck" -Password (ConvertTo-SecureString "duck" -AsPlainText -Force) -FullName "Full Name"; Add-LocalGroupMember -Group "Administrators" -Member "duck"; Enable-PSRemoting -Force
