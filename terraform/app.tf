resource "azurerm_log_analytics_workspace" "app" {
  name                = "app-workspace"
  location            = var.location
  resource_group_name = var.rg_name
  #sku                 = "PerGB2018"
  #retention_in_days   = 7
}

resource "azurerm_container_app_environment" "env" {
  name                       = "app-environment"
  location                   = var.location
  resource_group_name        = var.rg_name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.app.id
}

resource "azurerm_container_app" "app" {
  name                         = format("%sapp", var.resource_prefix)
  container_app_environment_id = azurerm_container_app_environment.env.id
  resource_group_name          = var.rg_name
  revision_mode                = "Single"

  secret {
    name = "blobsasurl"
    #value = format("%s%s/%s", data.azurerm_storage_account.storage_account.primary_blob_endpoint, var.storage_container_name, data.azurerm_storage_account_sas.app.sas)
    value = format("%s%s/%s", data.azurerm_storage_account.storage_account.primary_blob_endpoint, var.storage_container_name, data.azurerm_storage_account_blob_container_sas.sas.sas)
  }

  template {
    container {
      name  = "examplecontainerapp"
      image = var.container_image

      cpu    = 0.25
      memory = "0.5Gi"

      env {
        name  = "BLOB_CONTAINER_NAME"
        value = var.storage_container_name
      }

      env {
        name        = "BLOB_SAS_URL"
        secret_name = "blobsasurl"
      }
    }
  }

  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = 8501
    transport                  = "auto"
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}
