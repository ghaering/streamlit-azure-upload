variable "rg_name" {
  description = "Name of the resource group to deploy to"
  type        = string
}

variable "location" {
  description = "Location to create resources in"
  type        = string
  default     = "GermanyWestCentral"
}

variable "username" {
  description = "Name of the user running terraform"
  type        = string
}

variable "storage_container_name" {
  description = "Name of the storage container to create"
  type        = string
  default     = "upload"
}

