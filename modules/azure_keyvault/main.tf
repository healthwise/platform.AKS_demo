data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "keyvault-resource-group" {
  name     = "hw-west-rg-kv"
  location = var.LOCATION

  tags = {
    environment = var.ENVIRONMENT
  }
}


# Keyvault does not allow you to fully delete it for up to 90 days after its created (soft deletes)
# This will provide a random keyvault name for demo purposes
resource "random_id" "kvname" {
  byte_length = 5
  prefix = "keyvault"
}

resource "azurerm_key_vault" "azure_keyvault" {
  name                        = random_id.kvname.hex
  location                    = var.LOCATION
  resource_group_name         = azurerm_resource_group.keyvault-resource-group.name
  enabled_for_disk_encryption = true
  tenant_id                   = var.TENANT_ID

  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  sku_name = "standard"

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

    access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    key_permissions = [
      "get",
    ]
    secret_permissions = [
      "get", "backup", "delete", "list", "purge", "recover", "restore", "set",
    ]
    storage_permissions = [
      "get",
    ]
  }
}

resource "azurerm_key_vault_secret" "secret1" {
  name         = "myNewSecret"
  value        = "Success! This is the myNewSecret from Key Vault. Now give Glen money"
  key_vault_id = azurerm_key_vault.azure_keyvault.id
}

resource "azurerm_key_vault_secret" "secret2" {
  name         = "myOtherNewSecret"
  value        = "Success! This is the myOtherNewSecret from Key Vault. Now give Glen money"
  key_vault_id = azurerm_key_vault.azure_keyvault.id
}

resource "azurerm_key_vault_secret" "secret3" {
  name         = "myNestedNewSecret"
  value        = "My nested new secret: Im a nested secret, Glen also accepts checks and money orders"
  key_vault_id = azurerm_key_vault.azure_keyvault.id
}

resource "azurerm_key_vault_secret" "secret4" {
  name         = "myNestedOtherNewSecret"
  value        = "My nested other new secret: Im a nested secret, Glen also accepts checks and money orders"
  key_vault_id = azurerm_key_vault.azure_keyvault.id
}