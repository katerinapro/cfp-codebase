variable "location" {
  description = "The Azure location for resources"
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "The environment (e.g., dev, prod)"
  type        = string
  default     = "prod"
}

variable "image" {
  description = "The Docker image version"
  type        = string
  default     = "9028"
}
