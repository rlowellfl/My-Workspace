get-mailbox -ResultSize unlimited | foreach { 

$MailUser = $_.UserPrincipalName 

$stats= Get-MailboxStatistics $MailUser
$datetime = $stats.LastLogonTime

$date, $time = $datetime -split(' ')

New-Object -TypeName PSObject -Property @{
DisplayName = $stats.DisplayName
ItemCount = $stats.ItemCount
MailboxSize = $stats.TotalItemSize
LastLogonDate = $date
LastLogonTime = $time
Email = $MailUser


}

} | Export-Csv -Path C:\MailUsers.csv
