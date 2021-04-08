
##############################################################################################################
# Run line below to create a service principal
# az ad sp create-for-rbac --role="Owner" --scopes="/subscriptions/<YOUR AZURE SUB ID"

# {
#   "appId": "93e3fc30-8aa3-4c41-9695-60d##########",
#   "displayName": "azure-cli-2021-04-06-16-19-25",
#   "name": "http://azure-cli-2021-04-06-16-19-25",
#   "password": "12b9197d-e550-4f1d-9f5c-463##########",
#   "tenant": "cee5d4e9-42e5-48c2-8a03-3406fd5b9242"
# }
# Replace the values below with your own information 
###################  secrets  ##########################
SERVICE_PRINCIPAL_ID       = "93e3fc30-8aa3-4c41-9695-60d11##########"
SERVICE_PRINCIPAL_SECRET   = "12b9197d-e550-4f1d-9f5c-463d##########"
SUBSCRIPTION_ID            = "722daa54-db9c-4486-81e8-fe8e##########"
TENANT_ID                  = "cee5d4e9-42e5-48c2-8a03-3406f##########"

LOCATION                   = "westus"
ENVIRONMENT                = "staging"
ADMIN_GROUP_OBJECT_ID      = "5cffa0c2-b3d9-4b18-947c-df5##########"  # An active Directory group Id that you want to have full access to the cluster (eg. ENG-s api)
