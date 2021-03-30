resource "azurerm_resource_group" "acr-resource-group" {
  name     = "hw-west-rg-acr"
  location = var.LOCATION

  tags = {
    environment = var.ENVIRONMENT
  }
}

resource "azurerm_container_registry" "ContainerImages" {
  name                     = "hwwestacr"
  resource_group_name      = azurerm_resource_group.acr-resource-group.name
  location                 = var.LOCATION
  sku                      = "Premium"
  admin_enabled            = true
  georeplication_locations = [var.ACR_GEOREPLICATION_LOCATIONS]
  tags = {
    environment   = var.ENVIRONMENT
  }
}
