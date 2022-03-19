# this line is imported so that backend connection is extablished in 
#the pipeline
terraform {
    backend "azurerm" {}
}
# Configure the Microsoft Azure Provider
provider "azurerm" {
    subscription_id = "Pay-As-You-Go(acf8be16-4029-4672-bd15-7c4aa64a5a8a)"
    skip_provider_registration = "true"
    features {}
}
resource "azurerm_app_service_plan" "test" {
  name                = "azure-functions-test-service-plan-pradeep1989"
  location            = "westeurope"
  resource_group_name = "resource_group_name"
  kind                = "FunctionApp"
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}
resource "azurerm_application_insights" "test" {
  name                = "miel-test-terraform-insights-pradeep1989"
  location            = "westeurope"
  resource_group_name = "resource_group_name"
  application_type    = "web"
}
resource "azurerm_function_app" "test" {
  name                      = "miel-test-terraform-pradeep1989"
  location                  = "westeurope"
  resource_group_name       = "resource_group_name"
  app_service_plan_id       = azurerm_app_service_plan.test.id
  storage_connection_string = "storage_connection_string"
  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.test.instrumentation_key
  }
}