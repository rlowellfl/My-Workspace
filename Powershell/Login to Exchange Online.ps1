$a = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $a -Authentication Basic –AllowRedirection
Import-PSSession $Session