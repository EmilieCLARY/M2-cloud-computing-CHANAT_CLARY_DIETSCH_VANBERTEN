output "database" {
  value = length(module.database) == 0 ? null : {
    host     = local.database_connection.host
    port     = local.database_connection.port
    database = local.database.name
    username = local.database.username
    password = local.database.password
    ssl      = "enabled"
  }
  sensitive   = true
  description = "Database connection information"
}

output "api" {
  value = length(module.examples_api_service) == 0 ? null : {
    url = module.examples_api_service[0].url
  }
  description = "URL to access the HTTP API"
}

output "storage" {
  value = length(module.api_storage) == 0 ? null : {
    url = local.storage_url
  }
  description = "URL to access the storage account"
}

output "vnet_id" {
  value       = module.vnet.vnet_id
  description = "The ID of the virtual network"
}

output "subnet_ids" {
  value       = module.vnet.subnet_ids
  description = "The IDs of the subnets"
}