terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.46.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}
resource "azurerm_storage_account" "function_app_sa" {
  name                     = "fabrickamfuncappsa${var.resource_suffix}"
  resource_group_name      = var.resource_group_name
  location                 = var.resource_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "function_app_service_plan" {
  name                = "${var.resource_base_name}-${var.resource_suffix}-service-plan"
  resource_group_name = var.resource_group_name
  location            = var.resource_location
  os_type             = "Windows"
  sku_name            = "Y1"
}

resource "azurerm_windows_function_app" "function_app" {
  name                = "${var.resource_base_name}-${var.resource_suffix}-function-app"
  resource_group_name = var.resource_group_name
  location            = var.resource_location

  storage_account_name        = azurerm_storage_account.function_app_sa.name
  storage_account_access_key  = azurerm_storage_account.function_app_sa.primary_access_key
  service_plan_id             = azurerm_service_plan.function_app_service_plan.id
  functions_extension_version = "~4"

  site_config {
    application_stack {
      dotnet_version = "v6.0"
    }
  }
}

locals {
  resource_group_name = var.resource_group_name
  location            = var.resource_location
  resource_base_name  = var.resource_base_name
}