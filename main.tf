variable "green_enabled" {
  default = false
  type    = bool
}

variable "tier" {}
variable "sa_name" {}

resource "azurerm_resource_group" "rg" {
  name     = "test_rg"
  location = "eastus"
  tags     = {}
}

module "blue" {
  source   = "./module"
  rg_name  = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  tier     = var.tier
  sa_name  = var.sa_name
}

module "green" {
  count    = var.green_enabled ? 1 : 0
  source   = "./module"
  rg_name  = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  tier     = var.tier
  sa_name  = var.sa_name
}