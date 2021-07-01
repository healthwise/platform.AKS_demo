resource "azurerm_resource_group" "acr-resource-group" {
  name     = "${var.PREFIX}-${var.ENVIRONMENT}-${var.LOCATION}-rg-acr"
  location = var.LOCATION

  tags = {
    environment = var.ENVIRONMENT
  }
}

resource "azurerm_container_registry" "ContainerImages" {
  name                     = "${var.PREFIX}${var.ENVIRONMENT}${var.PREFIX}acr"
  resource_group_name      = azurerm_resource_group.acr-resource-group.name
  location                 = var.LOCATION
  sku                      = "Premium"
  admin_enabled            = true
 
  georeplications = [{
    location = var.ACR_GEOREPLICATION_LOCATIONS
    tags     = {
      replica = "East"
    }
  }]

  tags = {
    environment   = var.ENVIRONMENT
  }
}
