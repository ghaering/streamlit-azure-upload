module "app" {
  #source                 = "git::https://github.com/ghaering/streamlit-azure-upload.git//terraform"
  source                 = "../terraform"
  resource_prefix        = var.username
  storage_account_name   = local.storage_account_name
  storage_container_name = var.storage_container_name
  rg_name                = var.rg_name
  location               = var.location
}
