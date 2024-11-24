output "url" {
  value       = azurerm_storage_account.storage.primary_blob_endpoint
  description = "Hostname to connect to the storage account"
}

output "service_binding_id" {
  value       = azurerm_role_assignment.service_binding.id
  description = "ID of the service principal role assignment"
}

output "user_binding_id" {
  value       = azurerm_role_assignment.user_binding.id
  description = "ID of the user role assignment"
}

output "app_service_binding_id" {
  value       = length(azurerm_role_assignment.app_service_binding) > 0 ? azurerm_role_assignment.app_service_binding[0].id : null
  description = "ID of the app service role assignment"
}