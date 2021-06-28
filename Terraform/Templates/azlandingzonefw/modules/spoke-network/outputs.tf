output "spokeNetworkName" {
  value = azurerm_virtual_network.spoke.name
}

output "spokeNetworkID" {
  value = azurerm_virtual_network.spoke.id
}

output "spokeSubnetName" {
  value = azurerm_subnet.subnet1.name
}

output "spokeSubnetRange" {
  value = var.spokeSubRange
}