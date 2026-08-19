terraform {
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = ">=4.0"
      }
    }
}
provider "azurerm" {
    features {}
}
resource "azurerm_resource_group" "rg" {
    name = var.resource_group_name
    location = var.location
}
resource "azurerm_service_plan" "app_service" {
    name = var.app_service_plan_name
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    os_type = "Windows"
    sku_name = "B1"
}
resource "azurerm_windows_web_app" "web_app" {
    name = var.web_app_name
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    service_plan_id = azurerm_service_plan.app_service.id
    site_config {
        application_stack {
          dotnet_version = "v10.0"
          current_stack = "dotnet"
        }

    }


}