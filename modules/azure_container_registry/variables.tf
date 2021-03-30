variable "LOCATION" {
  type        = string
  description = "This is a constant that refers to the Azure Region"
}

variable "ENVIRONMENT" {
  type        = string
  description = "The server environment (test, development, production, etc)"
}

variable "ACR_GEOREPLICATION_LOCATIONS" {
  type        = string
  default     = "East US"
  description = "The Azure geo-replication location for the container registry"
}
