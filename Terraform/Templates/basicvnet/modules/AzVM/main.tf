resource "azurerm_resource_group" "Compute" {
  name     = var.computeRGName
  location = var.location
}

# Create a virtual NIC and attach to the vnet/subnet
resource "azurerm_network_interface" "vmNIC" {
  name                = "NIC-${var.vmNicName}"
  location            = azurerm_resource_group.Compute.location
  resource_group_name = azurerm_resource_group.Compute.name

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
  admin_password      = data.azurerm_key_vault_secret.vmuserpass.value
  network_interface_ids = [
    azurerm_network_interface.vmNIC.id,
  ]

  os_disk {
    name                 = "MD-OS-"+var.vmname
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb = "31"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}