resource "random_string" "storage_account_name" {
  length  = 10
  special = false
  upper   = false
}
