resource "azurerm_resource_group" "AKSRG" {
  name     = "hwdemo-rg-westus-aks"
  location = var.LOCATION
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "hwdemo-aks-westus"
  location            = var.LOCATION
  resource_group_name = azurerm_resource_group.AKSRG.name
  dns_prefix          = "hwdemo-aks-dns"

  default_node_pool {
    name       = "default"
    node_count = var.AKS_NODE_COUNT # 2
    vm_size    = var.AKS_VM_SIZE # "Standard_B2ms"
  }

  role_based_access_control {
      enabled = true
      azure_active_directory {
          managed = true        
          admin_group_object_ids = [
              var.ADMIN_GROUP_OBJECT_ID
          ]  
      }
  }


  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.ENVIRONMENT
  }
}

data "azurerm_subscription" "current" {} 

data "azurerm_user_assigned_identity" "agentpool_identity" {
  name                = "${azurerm_kubernetes_cluster.aks.name}-agentpool"
  resource_group_name = azurerm_kubernetes_cluster.aks.node_resource_group
}
# Assign the kublet user access to the ACR
resource "azurerm_role_assignment" "acrpull_role" {
  scope                            = var.CONTAINER_REGISTRY_ID
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

# Assign the agent pool user some roles
resource "azurerm_role_assignment" "aks_managed_identity_operator" {
  scope                            = "${data.azurerm_subscription.current.id}/resourceGroups/${azurerm_kubernetes_cluster.aks.node_resource_group}"
  role_definition_name             = "Managed Identity Operator"
  principal_id                     =  data.azurerm_user_assigned_identity.agentpool_identity.principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "aks_managed_vm_contributor" {
  scope                            = "${data.azurerm_subscription.current.id}/resourceGroups/${azurerm_kubernetes_cluster.aks.node_resource_group}"
  role_definition_name             = "Virtual Machine Contributor"
  principal_id                     =  data.azurerm_user_assigned_identity.agentpool_identity.principal_id
  skip_service_principal_aad_check = true
}

# For the environment Keyvault
resource "azurerm_role_assignment" "keyvault_managed_identity_operator" {
  scope                            = "${data.azurerm_subscription.current.id}/resourceGroups/${var.KEYVAULT_RESOURCE_GROUP}"
  role_definition_name             = "Managed Identity Operator"
  principal_id                     = data.azurerm_user_assigned_identity.agentpool_identity.principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "keyvault_reader_role" {
  scope                            = var.KEYVAULT_ID
  role_definition_name             = "Reader"
  principal_id                     = data.azurerm_user_assigned_identity.agentpool_identity.principal_id 
  skip_service_principal_aad_check = true
}

resource "azurerm_key_vault_access_policy" "AKSPrincipalAccessPolicy" {
  key_vault_id = var.KEYVAULT_ID

  tenant_id = var.TENANT_ID
  object_id = data.azurerm_user_assigned_identity.agentpool_identity.principal_id

  secret_permissions = [
      "get",
      "list",
      "recover"
    ]
}
# END "For the environment Keyvault"

# We have a Keyvault instance in our subscription that is controlled by the DEO Team
# It stores the certificates for our domains.
# It is not terraformed.  We use the code below to access the keyvault values directly from Azure 

# For the Shared DEO environment Keyvault, Uncomment below if needed
# data "azurerm_key_vault" "SharedDeoKeyvault" {
#   name                = var.SHARED_KEYVAULT
#   resource_group_name = var.SHARED_KEYVAULT_RESOURCE_GROUP
# }

# resource "azurerm_role_assignment" "keyvault_managed_identity_operator_DEO" {
#   scope                            = "${data.azurerm_subscription.current.id}/resourceGroups/${var.SHARED_KEYVAULT_RESOURCE_GROUP}"
#   role_definition_name             = "Managed Identity Operator"
#   principal_id                     = data.azurerm_user_assigned_identity.agentpool_identity.principal_id
#   skip_service_principal_aad_check = true
# }

# resource "azurerm_role_assignment" "keyvault_reader_role_DEO" {
#   scope                            = data.azurerm_key_vault.SharedDeoKeyvault.id
#   role_definition_name             = "Reader"
#   principal_id                     = data.azurerm_user_assigned_identity.agentpool_identity.principal_id
#   skip_service_principal_aad_check = true
# }

# resource "azurerm_key_vault_access_policy" "AKSPrincipalAccessPolicy_DEO" {
#   key_vault_id = data.azurerm_key_vault.SharedDeoKeyvault.id

#   tenant_id = var.TENANT_ID
#   object_id = data.azurerm_user_assigned_identity.agentpool_identity.principal_id

#   secret_permissions = [
#       "get",
#       "list",
#       "recover"
#     ]

#   certificate_permissions = [
#       "get",
#       "list",
#       "GetIssuers",
#       "ListIssuers"
#     ]
# }
