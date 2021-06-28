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
  name = var.networkRGName
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

# Deploy one or more spoke virtual networks
module "spoke-network" {
  depends_on = [
    module.vnet-gateway,
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
}