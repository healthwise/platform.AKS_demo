output "KEYVAULT_ID" {
    description = "Keyvault resource ID"
    value       = azurerm_key_vault.azure_keyvault.id
}

output "KEYVAULT_URI" {
    description = "Keyvault resource ID"
    value       = azurerm_key_vault.azure_keyvault.vault_uri
}

output "KEYVAULT_RESOURCE_GROUP" {
    description = "Keyvault resource group"
    value       = azurerm_resource_group.keyvault-resource-group.name
}