$contacts | ForEach {Set-Contact $_.Name -Phone $_.Phone}

Import-Csv .\BoardExport.csv|%{New-MailContact -Name $_.Fullname -DisplayName $_.Fullname -ExternalEmailAddress $_.Email -FirstName $_.FirstName -LastName $_.LastName}
$Contacts = Import-CSV .\BoardExport.csv
$contacts | ForEach {Add-DistributionGroupMember -identity $_.Group -Member $_.Email}