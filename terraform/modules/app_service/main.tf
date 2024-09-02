resource "azurerm_app_service" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = var.app_service_plan_id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    linux_fx_version = "DOCKER|${var.docker_registry_login_server}/rates-api:${var.docker_image}"
    ftps_state       = "Disabled"
  }

  app_settings = {
    DATABASE_CONNECTION_STRING = "@Microsoft.KeyVault(VaultName=${var.key_vault_name};SecretName=db-connection-string)"
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    DOCKER_REGISTRY_SERVER_URL          = "https://${var.docker_registry_login_server}"
    DOCKER_CUSTOM_IMAGE_NAME            = "${var.docker_registry_login_server}/rates-api:${var.docker_image}"
    WEBSITES_PORT                       = "3000"
  }
}
