output "azFirewallPIP" {
  value = azurerm_public_ip.afwPIP.ip_address
}

output "azFirewallPrivateIP" {
  value = azurerm_firewall.azfirewall.ip_configuration[0].private_ip_address
}