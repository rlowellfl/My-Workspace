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

resource "azurerm_monitor_diagnostic_setting" "LogAn-AFW" {
  name               = "Monitor-${azurerm_firewall.azfirewall.name}"
  target_resource_id = azurerm_firewall.azfirewall.id
log_analytics_workspace_id = var.logAnID

  log {
    category = "AzureFirewallApplicationRule"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "AzureFirewallNetworkRule"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "AzureFirewallDnsProxy"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}

resource "azurerm_firewall_network_rule_collection" "standard_net_rules" {
  name                = "standard_network_rules"
  azure_firewall_name = azurerm_firewall.azfirewall.name
  resource_group_name = azurerm_firewall.azfirewall.resource_group_name
  priority            = 100
  action              = "Allow"

  rule {
    name = "RDP-Inbound"

    source_addresses = [
      var.homeIP,
    ]

    destination_ports = [
      "3389",
    ]

    destination_addresses = [
      "10.20.0.0/16",
      "10.30.0.0/16",
    ]

    protocols = [
      "TCP"
    ]
  }
  rule {
    name = "Spoke_Pings"

    source_addresses = [
      "10.20.0.0/16",
      "10.30.0.0/16",
    ]

    destination_ports = [
      "*",
    ]

    destination_addresses = [
      "10.20.0.0/16",
      "10.30.0.0/16",
    ]

    protocols = [
      "ICMP",
    ]
  }
  rule {
    name = "HTTP_HTTPS_Outbound"

    source_addresses = [
      "10.20.0.0/16",
      "10.30.0.0/16",
    ]

    destination_ports = [
      "80",
      "443",
    ]

    destination_addresses = [
      "*",
    ]

    protocols = [
      "TCP",
    ]
  }
}

resource "azurerm_firewall_nat_rule_collection" "standard_nat_rules" {
  name                = "standard_nat_rules"
  azure_firewall_name = azurerm_firewall.azfirewall.name
  resource_group_name = azurerm_firewall.azfirewall.resource_group_name
  priority            = 100
  action              = "Dnat"

  rule {
    name = "RDPtoShared"

    source_addresses = [
      var.homeIP,
    ]

    destination_ports = [
      "3390",
    ]

    destination_addresses = [
      azurerm_public_ip.afwPIP.ip_address
    ]

    translated_port = 3390

    translated_address = "10.20.0.4"

    protocols = [
      "TCP",
    ]
  }
  rule {
    name = "RDPtoApps"

    source_addresses = [
      var.homeIP,
    ]

    destination_ports = [
      "3389",
    ]

    destination_addresses = [
      azurerm_public_ip.afwPIP.ip_address
    ]

    translated_port = 3389

    translated_address = "10.30.0.4"

    protocols = [
      "TCP",
    ]
  }
}