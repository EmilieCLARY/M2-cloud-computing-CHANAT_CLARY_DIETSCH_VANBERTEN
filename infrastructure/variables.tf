variable "vnet_name" {
  default = "junia-vnet"
}
variable "postgres_name" {
  default = "junia-postgres"
}
variable "storage_account_name" {
  default = "juniastorageacct"
}

variable "location" {
  type        = string
  default     = "francecentral"
  description = "Location of the resources"
}

variable "resource_group_name" {
  type        = string
  default     = "cloud-computing-project"
  description = "Name of the resource group in which all resource are grouped"
}

#########
# Flags #
#########


variable "enable_database" {
  type        = bool
  default     = false
  description = "Whether to deploy the PostgreSQL database or not"
}

variable "enable_api" {
  type        = bool
  default     = false
  description = "Whether to deploy the HTTP API or not"
}

variable "enable_storage" {
  type        = bool
  default     = false
  description = "Whether to deploy the blob storage"
}

variable "enable_storage_read_for_user" {
  type        = bool
  default     = false
  description = "Whether to enable IAM service blob storage reader role for the user"
}

variable "enable_storage_read_for_api" {
  type        = bool
  default     = false
  description = "Whether to enable IAM blob storage reader role binding for the API service"
}

variable "enable_storage_read_for_app_service" {
  type        = bool
  default     = false
  description = "Whether to enable IAM blob storage reader role binding for the app service"
}


############
# Identity #
############


variable "github_handle" {
  type        = string
  nullable    = false
  description = "Your GitHub username (not your email, your @username)"
}

variable "subscription_id" {

}

variable "email_address" {
  type        = string
  nullable    = false
  description = "Your JUNIA email address. Example: firstname.lastname@*.junia.com"
}


############
# Database #
############


variable "database_server_name" {
  type        = string
  default     = null
  description = "Name of the database server. Example: playground-computing-handlegithub"
}

variable "database_name" {
  type        = string
  default     = null
  description = "Name for the database within the server"
}

variable "database_username" {
  type        = string
  default     = null
  description = "Administrator username for the database"
}

variable "database_password" {
  type        = string
  default     = null
  sensitive   = true
  description = <<EOT
"Administrator password for the database"

The password must be at least 8 characters and at most 128 characters.
The password must contain characters from three of the following categories:
– English uppercase letters
- English lowercase letters
- numbers (0-9)
- non-alphanumeric characters (!, $, #, %, etc.)
EOT
}

variable "allowed_ip_address" {
  type        = string
  description = "IP address allowed to access the PostgreSQL database"
}

resource "random_password" "database_password" {
  length      = 24
  min_special = 1
  min_numeric = 2
  min_lower   = 2
  min_upper   = 2
}


#############
# New relic #
#############


variable "new_relic_licence_key" {

}

###########
# Storage #
###########


variable "storage_name" {
  type        = string
  default     = null
  description = "Name of the storage account"
}

variable "api_subnet_name" {
  type        = string
  default     = "api-subnet"
  description = "Name of the subnet for the API service"
}

variable "storage_subnet_name" {
  type        = string
  default     = "storage-subnet"
  description = "Name of the subnet for the storage account"
}

variable "log_analytics_workspace_name" {
  type        = string
  default     = "example-workspace"
  description = "Name of the Log Analytics workspace"
}

variable "public_ip_name" {
  type        = string
  default     = "gateway-public-ip"
  description = "Public IP name for the gateway"
}

variable "gateway_subnet_name" {
  type        = string
  default     = "gateway-subnet"
  description = "Name of the subnet for the gateway"
}

variable "application_gateway_name" {
  type        = string
  default     = "application-gateway"
  description = "Name of the application gateway"
}

variable "app_service_fqdn" {
  type        = string
  default     = "app-service.example.com"
  description = "FQDN of the app service"
}


##########
# Locals #
##########


locals {
  database = {
    server_name = var.database_server_name != null ? var.database_server_name : "playground-computing-${var.github_handle}"
    name        = var.database_name != null ? var.database_name : var.github_handle
    username    = var.database_username != null ? var.database_username : var.github_handle
    password    = var.database_password != null ? var.database_password : random_password.database_password.result
  }

  storage = {
    name = var.storage_name != null ? var.storage_name : var.github_handle
  }
}
