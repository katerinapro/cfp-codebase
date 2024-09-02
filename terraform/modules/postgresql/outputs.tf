output "postgresql_server_id" {
  value = azurerm_postgresql_server.this.id
}

output "postgresql_database_name" {
  value = azurerm_postgresql_database.this.name
}

output "server_fqdn" {
  value = azurerm_postgresql_server.this.fqdn
}

output "database_name" {
  value = azurerm_postgresql_database.this.name
}

output "administrator_login" {
  value = azurerm_postgresql_server.this.administrator_login
}

output "server_name" {
  value = azurerm_postgresql_server.this.name
}
