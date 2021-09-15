variable "rg_name" {}
variable "sa_name" {}
variable "location" {}
variable "tier" {
  default = "standard"
}

resource "random_integer" "id" {
  min = 1
  max = 50000
}

resource "azurerm_storage_account" "staticwebapp" {
  name                     = format("%s%s", var.sa_name, random_integer.id.result)
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = var.tier
  account_replication_type = "LRS"
  tags                     = {}
}