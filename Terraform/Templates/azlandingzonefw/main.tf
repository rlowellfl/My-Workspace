#Provide required providers
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.63.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create the Network resource group
resource "azurerm_resource_group" "networkRGName" {
  name = "RG-${var.networkRGName}"
  location = var.location  
}

# Deploy the hub virtual network
module "hub-network" {
  source = "./modules/hub-network"
  location = var.location
  networkRGName = azurerm_resource_group.networkRGName.name
  hubVnetName = var.hubVnetName
  hubVnetRange = var.hubVnetRange
  hubSubName = var.hubSubName
  hubSubRange = var.hubSubRange
  hubGatewayRange = var.hubGatewayRange
}

# Deploy an Azure Firewall in the hub VNet
module "az-firewall" {
  source = "./modules/az-firewall"
  location = var.location
  networkRGName = azurerm_resource_group.networkRGName.name
  hubVnetName = module.hub-network.hubNetworkName
  afwSubnet = var.afwSubnet
}

#Create an Azure Private DNS Zone
#pending

# Deploy one or more spoke virtual networks
module "spoke-network" {
  depends_on = [
    module.az-firewall
  ]
  for_each = var.spoke_network
  source = "./modules/spoke-network"
  location = var.location
  networkRGName = azurerm_resource_group.networkRGName.name
  spokeVnetName = each.value["spokeVnetName"]
  spokeVnetRange = each.value["spokeVnetRange"]
  spokeSubName = each.value["spokeSubName"]   
  spokeSubRange = each.value["spokeSubRange"]
  hubNetworkName = module.hub-network.hubNetworkName
  hubNetworkID = module.hub-network.hubNetworkID
  azFirewallPrivateIP = module.az-firewall.azFirewallPrivateIP
  #pass in Private DNS info to associate
}

#DNS settings for azfw
#Define azfw rule collection (classic)
#Create LogAn workspace, pipe in Azfw logs