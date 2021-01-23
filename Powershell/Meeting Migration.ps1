#Install the MicrosoftTeams PowerShell module in an elevated PowerShell prompt:
Set-ExecutionPolicy Unrestricted
Install-Module MicrosoftTeams

#Import the module and initiate a Skype Online session:
Import-Module MicrosoftTeams
$sfbSession = New-CsOnlineSession
Import-PSSession $sfbSession

#Set org to Teams Only mode:
Grant-CsTeamsUpgradePolicy -PolicyName UpgradeToTeams -Global

#If an error results saying that an on-premise skype federation is in place, use the following cmdlet to remove that domain:
Disable-CsOnlineSipDomain -Domain Fabrikam.com

#Query to see if Global setting has updated after cmdlet runs:
Get-CsTeamsUpgradePolicy -Identity Global

#To manually initiate a Meeting Migration Service upgrade, create a CSV with a User column and list the email addresses of all users:
$MMSUpgrade = Import-CSV c:\import\MMSUpgrade.csv
$MMSUpgrade | ForEach {Start-CsExMeetingMigration -identity $_.User -TargetMeetingType Teams -confirm:$false} 
