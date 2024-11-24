variable "resource_group_name" {}
variable "location" {}
variable "vnet_name" {}
variable "api_subnet_name" {}
variable "storage_subnet_name" {}

variable "gateway_subnet_name" {
  description = "Name of the subnet for the gateway"
  type        = string
}
