variable "networkRGName" {
  type = string
}

variable "location" {
  type = string
}

variable "hubVnetName" {
  type = string
}

variable "logAnID" {
  type = string
}

variable "afwSubnet" {
  type = list(string)
}

variable "homeIP" {
  type = string
}