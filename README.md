# platform.AKS_demo
A sample AKS setup in terraform

## To apply, run the following command

First
 terraform init -var-file="secrets.tfvars"

## Then

 terraform plan -var-file="secrets.tfvars"


## If everything passes, run the apply command

 terraform apply -var-file="secrets.tfvars"
