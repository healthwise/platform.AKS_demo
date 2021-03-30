data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "keyvault-resource-group" {
  name     = "hw-west-rg-kv"
  location = var.LOCATION

  tags = {
    environment = var.ENVIRONMENT
  }
}

resource "azurerm_key_vault" "azure_keyvault" {
  name                        = "hwdemo-keyvault-westus"
  location                    = var.LOCATION
  resource_group_name         = azurerm_resource_group.keyvault-resource-group.name
  enabled_for_disk_encryption = true
  tenant_id                   = var.TENANT_ID

  soft_delete_retention_days  = 30
  purge_protection_enabled    = true

  sku_name = "standard"

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
}