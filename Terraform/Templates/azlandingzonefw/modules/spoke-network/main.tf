# Create the spoke virtual network
resource "azurerm_virtual_network" "spoke" {
  name                = "VNet-${var.spokeVnetName}"
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
  name = "${var.spokeVnetName} to ${var.hubNetworkName}"
  resource_group_name          = var.networkRGName
  virtual_network_name         = azurerm_virtual_network.spoke.name
  remote_virtual_network_id    = var.hubNetworkID
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "spokefromhub" {
  name = "${var.spokeVnetName} from ${var.hubNetworkName}"
  resource_group_name          = var.networkRGName
  virtual_network_name         = var.hubNetworkName
  remote_virtual_network_id    = azurerm_virtual_network.spoke.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
}

resource "azurerm_route_table" "routeTable" {
  name                          = "RT-${azurerm_virtual_network.spoke.name}"
  location                      = var.location
  resource_group_name           = var.networkRGName
  disable_bgp_route_propagation = true
}

resource "azurerm_route" "toFirewall" {
  name                = "ToFirewall"
  resource_group_name = azurerm_route_table.routeTable.resource_group_name
  route_table_name    = azurerm_route_table.routeTable.name
  address_prefix      = "0.0.0.0/0"
  next_hop_type       = "VirtualAppliance"
  next_hop_in_ip_address = var.azFirewallPrivateIP
}