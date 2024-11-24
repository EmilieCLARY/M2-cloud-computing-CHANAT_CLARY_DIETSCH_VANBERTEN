// Name of the public IP address
variable "public_ip_name" {
  description = "Public IP name"
  type        = string
}

// Name of the resource group
variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

// Physical location of the resource group and modules
variable "physical_location" {
  description = "Resource group and modules physical location"
  type        = string
}

// Name of the virtual network
variable "vnet_name" {
  description = "Virtual network name"
  type        = string
}

// Name of the subnet for the gateway
variable "gateway_subnet_name" {
  description = "Subnet name"
  type        = string
}

// ID of the subnet for the gateway
variable "gateway_subnet_id" {
  description = "Subnet ID"
  type        = string
}

// Name of the application gateway
variable "application_gateway_name" {
  description = "Application gateway name"
  type        = string
}

// Fully qualified domain name of the app service
variable "app_service_fqdn" {
  description = "App service FQDN"
  type        = string
}