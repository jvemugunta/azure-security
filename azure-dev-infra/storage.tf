resource "azurerm_resource_group" "eastus-jagadishtf" {
  name     = "eastus-jagadishtf"
  location = "East US"
}

resource "azurerm_storage_account" "jagadishrunbookstfstate" {
  name                            = "jagadishrunbookstfstate"
  resource_group_name             = azurerm_resource_group.eastus-jagadishtf.name
  location                        = azurerm_resource_group.eastus-jagadishtf.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false

  tags = {
    environment = "dev"
  }
}

resource "azurerm_storage_container" "jagadishrunbookstf" {
  name                  = "jagadishrunbookstf"
  storage_account_name  = azurerm_storage_account.jagadishrunbookstfstate.name
  container_access_type = "blob"
}

data "azurerm_storage_account_sas" "jagadishrunbookstfstate" {
  connection_string = azurerm_storage_account.jagadishrunbookstfstate.primary_connection_string
  https_only        = true
  signed_version    = "2017-07-29"

  resource_types {
    service   = true
    container = false
    object    = false
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = "2022-08-28T00:00:00Z"
  expiry = "2023-12-31T00:00:00Z"

  permissions {
    read    = true
    write   = true
    delete  = false
    list    = false
    add     = true
    create  = true
    update  = false
    process = false
    tag     = false
    filter  = false
  }
}

output "sas_url_query_string" {
  value     = data.azurerm_storage_account_sas.jagadishrunbookstfstate.sas
  sensitive = true
}