output "vmUserName" {
  value = data.azurerm_key_vault_secret.vmUserName.value
}

output "vmPassword" {
  value = data.azurerm_key_vault_secret.vmPassword.value
}