terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 2.63.0"
    }
  }
  required_version = ">= 0.13"
}

provider "azurerm" {
  version = "~> 2.63.0"
   features{
    key_vault {
        purge_soft_delete_on_destroy = false
        recover_soft_deleted_key_vaults = true
      }
   }

  subscription_id = var.SUBSCRIPTION_ID
  tenant_id       = var.TENANT_ID
  client_id       = var.SERVICE_PRINCIPAL_ID
  client_secret   = var.SERVICE_PRINCIPAL_SECRET
}

# Creates an Azure Container Registry
module "container_registry" {
  source = ".//modules/azure_container_registry/"

  ENVIRONMENT                   = var.ENVIRONMENT
  LOCATION                      = var.LOCATION
  PREFIX                        = var.PREFIX
  ACR_GEOREPLICATION_LOCATIONS  = "East US"
}

# Creates an Azure Keyvault
module "keyvault" {
  source = ".//modules/azure_keyvault/"

  ENVIRONMENT                   = var.ENVIRONMENT
  LOCATION                      = var.LOCATION
  PREFIX                        = var.PREFIX
  # var.TENANT_ID pulls its value from the root variables file
  # if using azure devops pipelines, var. variables must be Uppercased
  TENANT_ID                     = var.TENANT_ID
}

module "kubernetes" {
source = ".//modules/azure_kubernetes_service/"

  KEYVAULT_RESOURCE_GROUP                       = module.keyvault.KEYVAULT_RESOURCE_GROUP
  LOCATION                                      = var.LOCATION
  PREFIX                                        = var.PREFIX
  ENVIRONMENT                                   = var.ENVIRONMENT
  KEYVAULT_ID                                   = module.keyvault.KEYVAULT_ID
  TENANT_ID                                     = var.TENANT_ID
  ADMIN_GROUP_OBJECT_ID                         = var.ADMIN_GROUP_OBJECT_ID
  CONTAINER_REGISTRY_ID                         = module.container_registry.Container_Registry_Id
  AKS_VM_SIZE                                   = "Standard_B4ms" # The size of the VM that will run each node
  AKS_NODE_COUNT                                = 2 # The initial number of AKS nodes, not including the master node which AKS provides for us. This is where your containers will run.
  # The following is the resource group for the Shared DEO keyvault
  # Since it is not managed in our terraform, we need to get these values from Azure, and pass them in as variables
  # Uncomment the lines below if needed
  # SHARED_KEYVAULT_RESOURCE_GROUP                = var.SHARED_KEYVAULT_RESOURCE_GROUP
  # SHARED_KEYVAULT                               = var.SHARED_KEYVAULT
}