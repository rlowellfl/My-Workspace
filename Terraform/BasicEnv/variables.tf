variable "rgName" {
  type = string
  description = "The name of the new resource group"
}

variable "regionName" {
  type  = string
  description = "Provide a region to deploy the new environment"
  default = "EastUS2"
}

variable "vnetName" {
  type  = string
  description = "Provide a name for the new VNet"
}

variable "vnetRange" {
  type  = list
  description = "Provide an address range in CIDR notation. Default 10.0.0.0/16"
  default = ["10.0.0.0/16"]
}

variable "vnetSubnetName" {
  type  = string
  description = "Provide a name for the new subnet. Default Subnet1"
  default = "Subnet1"
}

variable "vnetSubnetRange" {
  type  = list
  description = "Provide an address range in CIDR notation. Default 10.0.0.0/24"
  default = ["10.0.0.0/24"]
}

variable "vmName" {
  type  = string
  description = "Provide a name for the new VM"
}

variable "vmSize" {
  type  = string
  description = "Provide a size for the VM. Default Standard_B1ms"
  default = "Standard_B1ms"
}

variable "vmNicName" {
  type  = string
  description = "Provide a name for the VM's NIC"
}

variable "keyVaultName" {
  type  = string
  description = "Provide a Name for the Key Vault which stores the VM password"
}

variable "keyVaultRGName" {
  type  = string
  description = "Provide a Resource Group for the Key Vault which stores the VM password"
}
