variable "app_service_plan_id" {
  description = "The ID of the App Service Plan"
  type        = string
}

variable "docker_registry_login_server" {
  description = "The login server URL of the Docker registry"
  type        = string
}

variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "docker_image" {
  description = "The name of the Docker Image"
  type        = string
}

variable "name" {
  description = "The name of the App Service"
  type        = string
}

variable "location" {
  description = "The Azure location for the App Service"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group where the App Service will be created"
  type        = string
}