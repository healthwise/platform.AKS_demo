output "ContainerRegistry_LoginServer" {
  value = azurerm_container_registry.ContainerImages.login_server
}

output "Container_Registry_Id" {
  value = azurerm_container_registry.ContainerImages.id
}

output "Container_Registry_Admin_Username" {
  value = azurerm_container_registry.ContainerImages.admin_username
}

output "Container_Registry_Admin_Password" {
  value = azurerm_container_registry.ContainerImages.admin_password
}