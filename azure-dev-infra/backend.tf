terraform {
  backend "azurerm" {
    resource_group_name  = "eastus-jagadishtf"
    storage_account_name = "jagadishrunbookstfstate"
    container_name       = "jagadishrunbookstf"
    key                  = "eastus-jagadishtf.tfstate"
  }
}