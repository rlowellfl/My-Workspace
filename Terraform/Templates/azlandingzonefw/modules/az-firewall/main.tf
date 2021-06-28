resource "azurerm_subnet" "afwsubnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.networkRGName
  virtual_network_name = var.hubVnetName
  address_prefixes     = var.afwSubnet
}

resource "azurerm_public_ip" "afwPIP" {
  name                = "PIP-AFW-${var.hubVnetName}"
  location            = var.location
  resource_group_name = var.networkRGName
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "azfirewall" {
  name                = "AFW-${var.hubVnetName}"
  location            = var.location
  resource_group_name = var.networkRGName
  sku_tier = "Standard"
  threat_intel_mode = "Deny"

  ip_configuration {
    name                 = "azFirewallPIP"
    subnet_id            = azurerm_subnet.afwsubnet.id
    public_ip_address_id = azurerm_public_ip.afwPIP.id
  }
}