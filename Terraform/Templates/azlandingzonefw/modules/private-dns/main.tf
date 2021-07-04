

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "test"
  resource_group_name   = var.networkRGName
  private_dns_zone_name = azurerm_private_dns_zone.privdns.name
  virtual_network_id    = var.spokeVNetID
  registration_enabled = true
}