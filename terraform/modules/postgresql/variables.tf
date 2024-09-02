variable "administrator_login" {
  description = "The administrator login name for the PostgreSQL server"
  type        = string
}

variable "administrator_login_password" {
  description = "The administrator login password for the PostgreSQL server"
  type        = string
}

variable "database_name" {
  description = "The name of the PostgreSQL database"
  type        = string
}

variable "my_ip" {
  description = "The IP address of the local machine"
  type        = string
}

variable "name" {
  description = "The name of the PostgreSQL server"
  type        = string
}

variable "location" {
  description = "The Azure location for the PostgreSQL server"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the PostgreSQL server will be created"
  type        = string
}