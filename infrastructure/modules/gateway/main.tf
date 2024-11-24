// Create a public IP address
resource "azurerm_public_ip" "my_public_ip" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.physical_location
  allocation_method   = "Static"
}

// Define local variables for naming conventions
locals {
  backend_address_pool_name      = "${var.vnet_name}-beap"
  frontend_port_name             = "${var.vnet_name}-feport"
  frontend_ip_configuration_name = "${var.vnet_name}-feip"
  http_settings_name             = "${var.vnet_name}-be-htst"
  listener_name                  = "${var.vnet_name}-httplstn"
  request_routing_rule_name      = "${var.vnet_name}-rqrt"
  redirect_configuration_name    = "${var.vnet_name}-rdrcfg"
}

// Create an application gateway
resource "azurerm_application_gateway" "gateway" {
  name                = var.application_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.physical_location
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  // Configure the gateway IP
  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = var.gateway_subnet_id
  }

  // Configure the frontend port
  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  // Configure the frontend IP
  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.my_public_ip.id
  }

  // Configure the backend address pool
  backend_address_pool {
    name = local.backend_address_pool_name
    fqdns = [
      var.app_service_fqdn
    ]

  }

  // Configure the backend HTTP settings
  backend_http_settings {
    name                  = local.http_settings_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    path                  = "/"
    protocol              = "Http"
    request_timeout       = 5
  }

  // Configure the HTTP listener
  http_listener {

    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  // Configure the request routing rule
  request_routing_rule {
    name                       = local.request_routing_rule_name
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_settings_name
  }
}

// Output the public IP address of the application gateway
output "application_gateway_ip" {
  value       = azurerm_public_ip.my_public_ip.ip_address
  description = "Public IP address of the Application Gateway"
}

