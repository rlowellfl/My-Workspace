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

variable "spoke_network" {
  type = map(object({
    spokeVnetName = string
    spokeVnetRange = list(string)
    spokeSubName = string
    spokeSubRange = list(string)
  }))
}