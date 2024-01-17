variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Location to deploy to"
  type        = string
}

variable "resource_prefix" {
  description = "Prefix for resource names"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9]+$", var.resource_prefix))
    error_message = "The string must contain only alphanumeric lowercase characters."
  }
}

variable "storage_account_name" {
  description = "Storage account to use for this app"
  type        = string
}

variable "storage_container_name" {
  description = "Name of the storage container"
  type        = string
}

variable "container_image" {
  default = "docker.io/ghaering/streamlit:latest"
}
