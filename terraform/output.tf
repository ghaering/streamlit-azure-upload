output "app_url" {
  value = format("https://%s", azurerm_container_app.app.ingress.0.fqdn)
}
