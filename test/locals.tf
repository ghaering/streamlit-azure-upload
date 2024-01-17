locals {
  storage_account_name = format("%s%s", var.username, random_string.storage_account_name.result)
}
