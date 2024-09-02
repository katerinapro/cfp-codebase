resource "azurerm_postgresql_server" "this" {
  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  sku_name                        = "GP_Gen5_2"
  storage_mb                      = 5120
  version                         = "11"
  administrator_login             = var.administrator_login
  administrator_login_password    = var.administrator_login_password
  backup_retention_days           = 7
  ssl_enforcement_enabled         = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
  public_network_access_enabled   = true
}

resource "azurerm_postgresql_database" "this" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.this.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

resource "azurerm_postgresql_firewall_rule" "allow_my_ip" {
  name                = "AllowMyIP"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.this.name
  start_ip_address    = var.my_ip
  end_ip_address      = var.my_ip
}

resource "azurerm_postgresql_firewall_rule" "allow_azure_services" {
  name                = "AllowAzureServices"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.this.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
