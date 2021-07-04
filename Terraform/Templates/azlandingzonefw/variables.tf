variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "dnsName" {
  type = string
}

variable "hubVnetName" {
  type = string
}

variable "hubVnetRange" {
  type = list(string)
}

variable "hubSubName" {
  type = string
}

variable "hubSubRange" {
  type = list(string)
}

variable "hubGatewayRange" {
  type = list(string)
}

variable "spoke_network" {
  type = map(object({
    spokeVnetName = string
    spokeVnetRange = list(string)
    spokeSubName = string
    spokeSubRange = list(string)
    vmName = string
  }))
}

variable "afwSubnet" {
  type = list(string)
}

variable "homeIP" {
  type = string
}