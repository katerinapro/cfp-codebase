provider "azuread" {}

# Fetch client configuration
data "azurerm_client_config" "current" {}

# Define random resources
resource "random_password" "postgres_password" {
  length  = 16
  special = true
}

resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}

data "http" "my_ip" {
  url = "https://ipinfo.io/ip"
}

# Create resource group
module "resource_group" {
  source  = "./modules/resource_group"
  name    = "cfp-test-rg-01"
  location = var.location
}

# Create Key Vault
module "key_vault" {
  source             = "./modules/key_vault"
  name               = "cfp-test-kv-01-${var.environment}"
  location           = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = data.azurerm_client_config.current.object_id
  random_password    = random_password.postgres_password.result
}

# Create PostgreSQL Server
module "postgresql" {
  source               = "./modules/postgresql"
  name                 = "cfp-test-psg-01-${var.environment}"
  location             = module.resource_group.resource_group_location
  resource_group_name  = module.resource_group.resource_group_name
  administrator_login  = "psqladminun"
  administrator_login_password = random_password.postgres_password.result
  database_name        = "cfptest"
  my_ip                = chomp(data.http.my_ip.response_body)
}

# Create Container Registry
module "container_registry" {
  source             = "./modules/container_registry"
  name               = "cfpac01${random_integer.suffix.result}"
  resource_group_name = module.resource_group.resource_group_name
  location           = module.resource_group.resource_group_location
}

# Create App Service Plan
resource "azurerm_service_plan" "main" {
  name                = "cfp-app-service-plan-${random_integer.suffix.result}"
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  os_type             = "Linux"
  sku_name            = "S1"
}

# Create App Service
module "app_service" {
  source                  = "./modules/app_service"
  name                    = "cfp-app-service-${random_integer.suffix.result}"
  location                = module.resource_group.resource_group_location
  resource_group_name     = module.resource_group.resource_group_name
  app_service_plan_id     = azurerm_service_plan.main.id
  docker_registry_login_server = module.container_registry.container_registry_login_server
  docker_image                   = var.image
  key_vault_name          = module.key_vault.key_vault_name
}

# Create Service Principal
module "service_principal" {
  source         = "./modules/service_principal"
  display_name   = "cfp-test-app-${random_integer.suffix.result}"
}

# Create ACR Role Assignment
resource "azurerm_role_assignment" "acr_push" {
  scope                = module.container_registry.container_registry_id
  role_definition_name = "AcrPush"
  principal_id         = module.service_principal.service_principal_id
}

# Create Web App Role Assignment
resource "azurerm_role_assignment" "web_app_acr_pull" {
  scope                = module.container_registry.container_registry_id
  role_definition_name = "AcrPull"
  principal_id         = module.app_service.principal_id
}

# Key Vault Secret for DB Connection String
resource "azurerm_key_vault_secret" "db_connection_string" {
  depends_on = [
    module.key_vault,
    module.postgresql
  ]

  name         = "db-connection-string"
  value        = "Server=${module.postgresql.server_fqdn};Database=${module.postgresql.database_name};User Id=${module.postgresql.administrator_login}@${module.postgresql.server_name};Password=${random_password.postgres_password.result};SslMode=Require;"
  key_vault_id = module.key_vault.key_vault_id
}
