data "azurerm_storage_account" "storage_account" {
  name                = var.storage_account_name
  resource_group_name = var.rg_name
}

data "azurerm_storage_container" "container" {
  name                 = var.storage_container_name
  storage_account_name = var.storage_account_name
}

locals {
  current_timestamp = timestamp()
  # Extract the date part (YYYY-MM-DD) from the current timestamp
  current_date = formatdate("YYYY-MM-DD", local.current_timestamp)
  # Construct the start of the day in RFC3339 format (YYYY-MM-DDT00:00:00Z)
  start_of_day = "${local.current_date}T00:00:00Z"
}

data "azurerm_storage_account_sas" "app" {
  connection_string = data.azurerm_storage_account.storage_account.primary_connection_string
  https_only        = true
  start             = local.start_of_day
  expiry            = timeadd(local.start_of_day, format("%dh", 2 * 365 * 24))
  services {
    blob  = true
    queue = true
    table = true
    file  = true
  }
  resource_types {
    service   = false
    container = true
    object    = true
  }
  permissions {
    read    = true
    write   = true
    delete  = true
    list    = true
    add     = true
    create  = true
    update  = true
    process = true
    tag     = true
    filter  = true
  }
}

data "azurerm_storage_account_blob_container_sas" "sas" {
  connection_string = data.azurerm_storage_account.storage_account.primary_connection_string
  container_name    = var.storage_container_name
  https_only        = true

  start  = timeadd(timestamp(), "-24h")
  expiry = timeadd(timestamp(), "48h")

  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = true
    list   = true
  }
}
