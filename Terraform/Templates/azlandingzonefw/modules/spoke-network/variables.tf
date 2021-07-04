variable "networkRGName" {
  type = string
}

variable "location" {
  type = string
}

variable "spokeVnetName" {
  type = string
}

variable "spokeVnetRange" {
  type = list(string)
}

variable "spokeSubName" {
  type = string
}

variable "spokeSubRange" {
  type = list(string)
}

variable "hubNetworkName" {
}

variable "hubNetworkID" {
}

variable "azFirewallPrivateIP" {
  type = string
}

variable "dnsName" {
  type = string
}

variable "vmName" {
  type = string
}

variable "computeRGName" {
  type = string
}

variable "vmUserName" {
  type = string
}

variable "vmUserPass" {
  type = string
}