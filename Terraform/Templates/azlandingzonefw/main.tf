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

# Configure the Terraform backend on Azure storage
terraform {
  backend "azurerm" {
    resource_group_name  = "Non-TF"
    storage_account_name = "architechstfstatefiles"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}

# Create the Network resource group
resource "azurerm_resource_group" "networkRGName" {
  name = "RG-${var.environment}-Network"
  location = var.location  
}

# Create the Compute resource group
resource "azurerm_resource_group" "computeRGName" {
  name = "RG-${var.environment}-Compute"
  location = var.location  
}

#Create a Private DNS zone for address resolution between vnets
resource "azurerm_private_dns_zone" "private_DNS" {
  name                = var.dnsName
  resource_group_name = azurerm_resource_group.networkRGName.name
}

#Create a Log Analytics Workspace to collect firewall logs
resource "azurerm_log_analytics_workspace" "LogAn_Workspace" {
  name                = "LogAn-AFW"
  location            = var.location
  resource_group_name = azurerm_resource_group.networkRGName.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
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
  dnsName = azurerm_private_dns_zone.private_DNS.name
}

# Deploy an Azure Firewall in the hub VNet
module "az-firewall" {
  source = "./modules/az-firewall"
  location = var.location
  networkRGName = azurerm_resource_group.networkRGName.name
  hubVnetName = module.hub-network.hubNetworkName
  afwSubnet = var.afwSubnet
  homeIP = var.homeIP
  logAnID = azurerm_log_analytics_workspace.LogAn_Workspace.id
}

#Access the Azure Key Vault containing the virtual machine credentials
module "vmKeyVault" {
  source = "./modules/key-vault"
}

# Deploy one or more spoke virtual networks
module "spoke-network" {
  depends_on = [
    module.az-firewall,
  ]
  for_each = var.spoke_network
  source = "./modules/spoke-network"
  location = var.location
  networkRGName = azurerm_resource_group.networkRGName.name
  computeRGName = azurerm_resource_group.computeRGName.name
  hubNetworkName = module.hub-network.hubNetworkName
  hubNetworkID = module.hub-network.hubNetworkID
  azFirewallPrivateIP = module.az-firewall.azFirewallPrivateIP
  dnsName = azurerm_private_dns_zone.private_DNS.name
  vmUserName = module.vmKeyVault.vmUserName
  vmUserPass = module.vmKeyVault.vmPassword
  spokeVnetName = each.value["spokeVnetName"]
  spokeVnetRange = each.value["spokeVnetRange"]
  spokeSubName = each.value["spokeSubName"]   
  spokeSubRange = each.value["spokeSubRange"]
  vmName = each.value["vmName"]
}