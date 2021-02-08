##Install the MicrosoftTeams PowerShell module in an elevated PowerShell prompt:
Set-ExecutionPolicy Unrestricted
Install-Module MicrosoftTeams

##Import the module and initiate a Skype Online session:
Import-Module MicrosoftTeams
$sfbSession = New-CsOnlineSession
Import-PSSession $sfbSession

##Set org to Teams Only mode:
Grant-CsTeamsUpgradePolicy -PolicyName UpgradeToTeams -Global

##Disable shared SIP address space in Microsoft 365 or Office 365 organization (post Skype on-premise shutdown):
Set-CsTenantFederationConfiguration -SharedSipAddressSpace $false

##If an error results saying that an on-premise skype federation is in place, use the following cmdlet to remove that domain if it is no longer being used:
Disable-CsOnlineSipDomain -Domain Fabrikam.com

##If the domain is being used, first convert the affected users to Teams Only mode individually before making the change:
##Export all licensed users to a CSV file called TeamsUpgrade.csv with the column heading User

$TeamsUpgrade = Import-CSV c:\upgrade\TeamsUpgrade.csv
$TeamsUpgrade | ForEach-Object {Grant-CsTeamsUpgradePolicy -PolicyName UpgradeToTeams -identity $_.Users -confirm:$false}

##Query to see if Global setting has updated after cmdlet runs:
Get-CsTeamsUpgradePolicy -Identity Global

##To manually initiate a Meeting Migration Service upgrade:
##Create a CSV with a User column and list the email addresses of all users, then run:
$MMSUpgrade = Import-CSV c:\upgrade\MMSUpgrade.csv
$MMSUpgrade | ForEach-Object {Start-CsExMeetingMigration -identity $_.User -TargetMeetingType Teams -confirm:$false}