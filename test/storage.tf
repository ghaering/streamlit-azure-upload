resource "azurerm_storage_account" "storage" {
  name                     = local.storage_account_name
  resource_group_name      = var.rg_name
  account_tier             = "Standard"
  account_replication_type = "GRS"
  location                 = var.location

  tags = {
    creator = var.username
  }
}

resource "azurerm_storage_container" "container" {
  name                  = var.storage_container_name
  storage_account_name  = local.storage_account_name
  container_access_type = "private"
}
