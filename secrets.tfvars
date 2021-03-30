
##############################################################################################################
# Run line below to create a service principal
# az ad sp create-for-rbac --role="Owner" --scopes="/subscriptions/<YOUR AZURE SUB ID"

# {
#   "appId": "7941bde5-c879-4826-9011-8cb2b1******",
#   "displayName": "azure-cli-2021-03-29-18-47-24",
#   "name": "http://azure-cli-2021-03-29-18-47-24",
#   "password": "5f719547-0573-4de9-8ca4-3d40da******",
#   "tenant": "cee5d4e9-42e5-48c2-8a03-3406fd5b9242"
# }
# Replace the values below with your own information 
###################  secrets  ##########################
SERVICE_PRINCIPAL_ID       = "7941bde5-c879-4826-9011-8cb2b1******"
SERVICE_PRINCIPAL_SECRET   = "5f719547-0573-4de9-8ca4-3d40da******"
SUBSCRIPTION_ID            = "722daa54-db9c-4486-81e8-fe8e9c******"
TENANT_ID                  = "cee5d4e9-42e5-48c2-8a03-3406fd5b9242"

LOCATION                   = "westus"
ENVIRONMENT                = "staging"
ADMIN_GROUP_OBJECT_ID      = "5cffa0c2-b3d9-4b18-947c-df55f8******"
