variable "networkRGName" {
  type = string
}

variable "location" {
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

variable "dnsName" {
  type = string
}