# Purpose: Create a virtual network with two subnets, one for the database and one for the API.
resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
}

# Create a subnet for the database with a service delegation for PostgreSQL
resource "azurerm_subnet" "database" {
  name                 = "database-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]

  delegation {
    name = "postgresql-delegation"
    service_delegation {
      name    = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
  
  depends_on = [
    azurerm_virtual_network.main
  ]
  
}

# Create a subnet for the API
resource "azurerm_subnet" "api" {
  name                 = var.api_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create a subnet for the storage account
resource "azurerm_subnet" "storage" {
  name                 = var.storage_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.3.0/24"]
}

# Create a subnet for the gateway
resource "azurerm_subnet" "gateway" {
  name                 = var.gateway_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.4.0/24"]
}

output "database_subnet_id" {
  value = azurerm_subnet.database.id
}

output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "api_subnet_id" {
  value = azurerm_subnet.api.id
}

output "storage_subnet_id" {
  value = azurerm_subnet.storage.id
}

output "gateway_subnet_id" {
  value = azurerm_subnet.gateway.id
}