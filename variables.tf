# To get an azure service principle run the following command from the command line 
# (assuming you have the AZ CLI installed)
# az login
# az ad sp create-for-rbac --role="Owner" --scopes="/subscriptions/<YOUR AZURE SUBSCRIPTION ID>"
# You will get a response like this
#  {
#    "appId": "***********",
#    "displayName": "azure-cli-2019-08-19-21-12-00",
#    "name": "http://azure-cli-2019-08-19-21-12-00",
#    "password": "***********",
#    "tenant": "***********"
#  }
# the service principle ID is the appID, the service principle secret is the password, and the tenant is the tenant

variable "SERVICE_PRINCIPAL_ID" {
  type        = string
  description = "The service principal 'appId' property, set as Owner for the subscription defined in the subscription-id variable."
  default     = "<appId>"
}

variable "SERVICE_PRINCIPAL_SECRET" {
  type        = string
  description = "The service principal 'password' property, set as Owner for the subscription defined in the subscription-id variable."
   default     = "<password>"
}

variable "SUBSCRIPTION_ID" {
  type        = string
  description = "The Azure subscription ID"
  default     = "<The subscription ID>"
}

variable "TENANT_ID" { 
  type = string
  description = "The Healthwise Tenant ID"
  default     = "<tenant>"
}

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

variable "ADMIN_GROUP_OBJECT_ID" {
  type = string
  description = "This is the Azure ad group object ID that will have admin access to the cluster"
}