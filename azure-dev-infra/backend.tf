terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate12659"
    container_name       = "tfstate"
    key                  = "tfstate12659.tfstate"
  }
}
