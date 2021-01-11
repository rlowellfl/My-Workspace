#This script enables the use of Azure AD authentication for Azure VPN Client connections to Azure
#Before you start, log into your Azure tenant as a global admin. Paste the following URL to approve Azure VPN Client as a permitted enterprise app: https://login.microsoftonline.com/common/oauth2/authorize?client_id=41b23e61-6c1e-4545-b367-cd054e0ed4b4&response_type=code&redirect_uri=https://portal.azure.com&nonce=1234&prompt=admin_consent
#Your tenant will need an existing VPN Gateway. Fill in the following 4 variables and then run the script:

$gatewayname = "insert your VPN gateway resource name here"
$rgname = "insert your VPN gateway resource group name here"
$dirID = "insert your Azure AD directory ID here"
$addresspool = "insert your desired VPN client address pool, ex: 192.168.0.0/24"
Connect-AzAccount
$gw = Get-AzVirtualNetworkGateway -Name $gatewayname -ResourceGroupName $rgname
Set-AzVirtualNetworkGateway -VirtualNetworkGateway $gw -VpnClientRootCertificates @()
Set-AzVirtualNetworkGateway -VirtualNetworkGateway $gw -AadTenantUri "https://login.microsoftonline.com/$dirID" -AadAudienceId "41b23e61-6c1e-4545-b367-cd054e0ed4b4" -AadIssuerUri "https://sts.windows.net/$dirID/" -VpnClientAddressPool $addresspool -VpnClientProtocol OpenVPN
$profile = New-AzVpnClientConfiguration -Name $gatewayname -ResourceGroupName $rgname -AuthenticationMethod "EapTls"
$PROFILE.VpnProfileSASUrl

#Copy the URL from the output of this script and paste into a browser to download the VPN Client config ZIP
#Unzip and make a note of the location of the “azurevpnconfig.xml” file.
#The azurevpnconfig.xml contains the settings for the VPN connection and can be imported directly into the Azure VPN Client application.
#The client can be downloaded from the Windows Store here: https://www.microsoft.com/en-us/p/azure-vpn-client/9np355qt2sqb?SilentAuth=1&activetab=pivot:overviewtab
#Microsoft Doc Center: https://docs.microsoft.com/en-us/azure/vpn-gateway/openvpn-azure-ad-tenant