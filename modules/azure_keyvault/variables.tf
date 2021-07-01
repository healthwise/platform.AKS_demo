variable "LOCATION" {
  type        = string
  description = "This is a constant that refers to the Azure Region"
}

variable "ENVIRONMENT" {
  type        = string
  description = "The server environment (test, development, production, etc)"
}

variable "TENANT_ID" { 
  type = string
  description = "The Healthwise Tenant ID"
}

variable "PREFIX" {
  type = string
}