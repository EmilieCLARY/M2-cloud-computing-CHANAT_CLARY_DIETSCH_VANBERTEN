resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
}

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

resource "azurerm_subnet" "api" {
  name                 = var.api_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
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
