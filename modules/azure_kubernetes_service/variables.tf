variable "LOCATION" {
  type        = string
  description = "This is a constant that refers to the Azure Region, the item[i].name node of the region object as returned by the CLI command 'az account list-locations'"
}

variable "ENVIRONMENT" {
  type = string
}

variable "PREFIX" {
  type = string
}

variable "KEYVAULT_RESOURCE_GROUP" {
  type = string
}

variable "KEYVAULT_ID" {
  type = string
}

variable "TENANT_ID" {
  type = string
}

variable "CONTAINER_REGISTRY_ID" {
  type = string
}

variable "ADMIN_GROUP_OBJECT_ID" {
  type = string
  description = "This is the Azure ad group object ID that will have admin access to the cluster"
}

variable "AKS_VM_SIZE" {
  type = string
  default = "Standard_B4ms"
}

variable "AKS_NODE_COUNT" {
  type = number
  default = 2
}

# Uncomment below if using a Shared DEO keyvault
# variable "SHARED_KEYVAULT"{
#   type        = string
#   description =  "The Azure resource name of the pre-existing Shared Keyvault. This is found in Azure. e.g. 'HW-DEO-T-Platform-KV' "
# }

# variable "SHARED_KEYVAULT_RESOURCE_GROUP"{
#   type        = string
#   description =  "The Azure resource group name of the pre-existing Shared Keyvault.  This is found in Azure. e.g. 'HW-Test-RG-DEO-Security' "
# }