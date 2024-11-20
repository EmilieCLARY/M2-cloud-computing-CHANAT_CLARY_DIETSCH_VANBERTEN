output "vnet_id" {
  value       = azurerm_virtual_network.example.id
  description = "The ID of the virtual network"
}

output "subnet_ids" {
  value       = { for subnet in azurerm_subnet.subnets : subnet.name => subnet.id }
  description = "The IDs of the subnets"
}
