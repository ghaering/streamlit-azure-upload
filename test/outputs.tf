output "storage_account_name" {
  description = "Name of the storage account created"
  value       = azurerm_storage_account.storage.name
}

output "app_url" {
  description = "URL of the app in the module"
  value       = module.app.app_url
}
