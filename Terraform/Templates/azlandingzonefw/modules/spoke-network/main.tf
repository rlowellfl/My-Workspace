# Create the spoke virtual network
resource "azurerm_virtual_network" "spoke" {
  name                = var.spokeVnetName
  address_space       = var.spokeVnetRange
  location            = var.location
  resource_group_name = var.networkRGName
}

# Create a subnet within the spoke virtual network
resource "azurerm_subnet" "subnet1" {
  name                 = var.spokeSubName
  resource_group_name  = azurerm_virtual_network.spoke.resource_group_name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = var.spokeSubRange
}

#Peer the spoke Vnet to the Hub Vnet
resource "azurerm_virtual_network_peering" "spoketohub" {
  name = lower("${var.spokeVnetName}toHub")
  resource_group_name          = var.networkRGName
  virtual_network_name         = azurerm_virtual_network.spoke.name
  remote_virtual_network_id    = var.hubNetworkID
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = true
}

resource "azurerm_virtual_network_peering" "spokefromhub" {
  name = lower("${var.spokeVnetName}fromHub")
  resource_group_name          = var.networkRGName
  virtual_network_name         = var.hubNetworkName
  remote_virtual_network_id    = azurerm_virtual_network.spoke.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
}

resource "azurerm_route_table" "routeTable" {
  name                          = "RT-${azurerm_virtual_network.spoke.name}"
  location                      = var.location
  resource_group_name           = var.networkRGName
  disable_bgp_route_propagation = true
}