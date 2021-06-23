output "hubNetworkName" {
  value = azurerm_virtual_network.hubNetwork.name
}

output "hubNetworkID" {
  value = azurerm_virtual_network.hubNetwork.id
}

output "hubGatewaySubnetID" {
  value = azurerm_subnet.gateway.id
}