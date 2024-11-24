resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_name  = var.storage_account_name
  container_access_type = "private"

  depends_on = [azurerm_storage_account.storage]
}

resource "azurerm_role_assignment" "service_binding" {
  scope                = azurerm_storage_account.storage.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = var.service_principal_id

  depends_on = [var.service_principal_id]
}

resource "azurerm_role_assignment" "user_binding" {
  scope                = azurerm_storage_account.storage.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = var.user_principal_id

  depends_on = [var.user_principal_id]
}

resource "azurerm_role_assignment" "app_service_binding" {
  count = var.app_service_principal_id != null ? 1 : 0

  scope                = azurerm_storage_account.storage.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = var.app_service_principal_id
}