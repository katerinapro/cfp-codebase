output "resource_group_name" {
  value = module.resource_group.resource_group_name
}

output "container_registry_id" {
  value = module.container_registry.container_registry_id
}

output "app_service_id" {
  value = module.app_service.app_service_id
}

output "postgresql_server_id" {
  value = module.postgresql.postgresql_server_id
}
