// Create a PostgreSQL Flexible Server
resource "azurerm_postgresql_flexible_server" "playground_computing" {
  administrator_login           = var.database_administrator_login
  administrator_password        = var.database_administrator_password
  auto_grow_enabled             = false
  backup_retention_days         = 7
  geo_redundant_backup_enabled  = false
  location                      = var.location
  name                          = var.server_name
  public_network_access_enabled = false # Disable public access to the server, only allow access from the virtual network
  resource_group_name           = var.resource_group_name
  sku_name                      = "B_Standard_B1ms"
  storage_tier                  = "P4"
  storage_mb                    = "32768"
  version                       = "16"
  zone                          = "1"
  delegated_subnet_id           = var.subnet_id # Associate the server with the subnet
  private_dns_zone_id           = azurerm_private_dns_zone.postgres.id  # Associate the server with the private DNS zone

  authentication {
    active_directory_auth_enabled = true  # Enable Azure Active Directory authentication
    password_auth_enabled         = true  # Enable password authentication
    tenant_id                     = var.entra_administrator_tenant_id # Tenant ID of the Azure Active Directory
  }
}

resource "azurerm_postgresql_flexible_server_active_directory_administrator" "administrator" {
  tenant_id           = var.entra_administrator_tenant_id
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_flexible_server.playground_computing.name
  principal_type      = var.entra_administrator_principal_type
  object_id           = var.entra_administrator_object_id
  principal_name      = var.entra_administrator_principal_name
}

resource "azurerm_private_dns_zone" "postgres" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres" {
  name                  = "${var.resource_group_name}-dns-link" # The name of the DNS link
  resource_group_name   = var.resource_group_name # The resource group of the DNS link
  private_dns_zone_name = azurerm_private_dns_zone.postgres.name # The name of the private DNS zone
  virtual_network_id    = var.virtual_network_id # The ID of the virtual network
}

# Allow access to the server from a specific IP address
resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_all" {
  name             = "AllowSpecificIP" 
  server_id        = azurerm_postgresql_flexible_server.playground_computing.id
  start_ip_address = var.allowed_ip_address
  end_ip_address   = var.allowed_ip_address
}

# Allow access to the server from the virtual network
resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_vnet" {
  name             = "AllowVNet"
  server_id        = azurerm_postgresql_flexible_server.playground_computing.id
  start_ip_address = "10.0.0.0"
  end_ip_address   = "10.255.255.255"
}

# Create a database on the server
resource "azurerm_postgresql_flexible_server_database" "database" {
  name      = var.database_name
  server_id = azurerm_postgresql_flexible_server.playground_computing.id
}
