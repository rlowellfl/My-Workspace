data "azurerm_key_vault" "vmCreds" {
  name                = "KV-EUS2-Terraform"
  resource_group_name = "Non-TF"
}

data "azurerm_key_vault_secret" "vmUserName" {
  name         = "vmUserName"
  key_vault_id = data.azurerm_key_vault.vmCreds.id
}

data "azurerm_key_vault_secret" "vmPassword" {
  name         = "vmPassword"
  key_vault_id = data.azurerm_key_vault.vmCreds.id
}