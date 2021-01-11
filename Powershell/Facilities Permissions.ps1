Remove-MailboxPermission -Identity "servicewpb@facilitiespro-sweep.com" -User "tcorrea@facilitiespro-sweep.com" -AccessRights FullAccess -InheritanceType All
Remove-MailboxPermission -Identity "tcorrea@facilitiespro-sweep.com" -User "servicewpb@facilitiespro-sweep.com" -AccessRights FullAccess -InheritanceType All
Remove-MailboxPermission -Identity "adminwpb@facilitiespro-sweep.com" -User "tcorrea@facilitiespro-sweep.com" -AccessRights FullAccess -InheritanceType All
Remove-MailboxPermission -Identity "tcorrea@facilitiespro-sweep.com" -User "adminwpb@facilitiespro-sweep.com" -AccessRights FullAccess -InheritanceType All
Remove-MailboxPermission -Identity "adminwpb@facilitiespro-sweep.com" -User "servicewpb@facilitiespro-sweep.com" -AccessRights FullAccess -InheritanceType All
Remove-MailboxPermission -Identity "servicewpb@facilitiespro-sweep.com" -User "adminwpb@facilitiespro-sweep.com" -AccessRights FullAccess -InheritanceType All