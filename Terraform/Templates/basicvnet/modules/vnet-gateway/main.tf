resource "azurerm_public_ip" "vnetGWIP" {
  name                = "PIP-VNetGW-1"
  location            = var.location
  resource_group_name = var.networkRGName
  allocation_method = "Static"
}

resource "azurerm_virtual_network_gateway" "vnetGWIP" {
  name                = "VNetGW-1"
  location            = var.location
  resource_group_name = var.networkRGName

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "Basic"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vnetGWIP.id
    private_ip_address_allocation = "Static"
    subnet_id                     = var.hubGatewaySubnetID
  }
}