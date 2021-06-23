

# Create the hub virtual network
resource "azurerm_virtual_network" "hubNetwork" {
  name                = var.hubVnetName
  address_space       = var.hubVnetRange
  location            = var.location
  resource_group_name = var.networkRGName
}

# Create a subnet within the hub virtual network
resource "azurerm_subnet" "subnet1" {
  name                 = var.hubSubName
  address_prefixes     = var.hubSubRange
  resource_group_name  = azurerm_virtual_network.hubNetwork.resource_group_name
  virtual_network_name = azurerm_virtual_network.hubNetwork.name
}

# Create a Gateway subnet within the hub virtual network
resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"
  address_prefixes     = var.hubGatewayRange
  resource_group_name  = azurerm_virtual_network.hubNetwork.resource_group_name
  virtual_network_name = azurerm_virtual_network.hubNetwork.name
}