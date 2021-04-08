#Provide providers
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.53.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

#Access the Azure Key Vault to retrieve the VM password
data "azurerm_key_vault" "keyvault" {
  name                = "${var.keyVaultName}"
  resource_group_name = "${var.keyVaultRGName}"
}

data "azurerm_key_vault_secret" "vmuserpass" {
  name         = "newVmPassword"
  key_vault_id = data.azurerm_key_vault.existing.id
}

output "secret_value" {
  value = data.azurerm_key_vault_secret.newVmPassword.value
}

# Create the resource group
resource "azurerm_resource_group" "resourceGroup" {
  name     = var.rgName
  location = var.regionName
}

# Create the virtual network
resource "azurerm_virtual_network" "vNet" {
  name                = var.vnetName
  address_space       = var.vnetRange
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name
}

# Create a subnet within the virtual network
resource "azurerm_subnet" "subnet1" {
  name                 = var.vnetSubnetName
  resource_group_name  = azurerm_resource_group.resourceGroup.name
  virtual_network_name = azurerm_virtual_network.vNet.name
  address_prefixes     = var.vnetSubnetRange
}

# Create a virtual NIC and attach to the vnet/subnet
resource "azurerm_network_interface" "vmNIC" {
  name                = var.vmNicName
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create an Azure virtual machine attached to the above resources
resource "azurerm_windows_virtual_machine" "vm1" {
  name                = var.vmName
  resource_group_name = azurerm_resource_group.resourceGroup.name
  location            = azurerm_resource_group.resourceGroup.location
  size                = var.vmSize
  admin_username      = "adminuser"
  admin_password      = data.azurerm_key_vault_secret.newVmPassword.value
  network_interface_ids = [
    azurerm_network_interface.vmNIC.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}