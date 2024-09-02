provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "terraformstatetestcfp01"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}