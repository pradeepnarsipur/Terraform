resource "azurerm_resource_group" "pradeep_example_rg" {
  name     = "azure-functions-test-rg"
  location = "West Europe"
}

resource "azurerm_storage_account" "pradeep_storaage_example" {
  name                     = "functions_app_testsa_1989"
  resource_group_name      = azurerm_resource_group.pradeep_example_rg.name
  location                 = azurerm_resource_group.pradeep_example_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "pradeep_example_app_service_plan" {
  name                = "azure-functions-test-service-plan"
  location            = azurerm_resource_group.pradeep_example_rg.location
  resource_group_name = azurerm_resource_group.pradeep_example_rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_function_app" "example" {
  name                       = "test-azure-functions_pradeep"
  location                   = azurerm_resource_group.pradeep_example_rg.location
  resource_group_name        = azurerm_resource_group.pradeep_example_rg.name
  app_service_plan_id        = azurerm_app_service_plan.pradeep_example_app_service_plan.id
  storage_account_name       = azurerm_storage_account.pradeep_storaage_example.name
  storage_account_access_key = azurerm_storage_account.pradeep_storaage_example.primary_access_key
  site_config {
    dotnet_framework_version="v6.0"
  }
}