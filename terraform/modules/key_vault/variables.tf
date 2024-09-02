variable "resource_group_name" {
  description = "The name of the resource group where the Key Vault will be created"
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID of the Azure Active Directory"
  type        = string
}

variable "object_id" {
  description = "The object ID for the access policy"
  type        = string
}

variable "random_password" {
  description = "Random password"
  type        = string
}

variable "name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "location" {
  description = "The Azure location for the Key Vault"
  type        = string
}