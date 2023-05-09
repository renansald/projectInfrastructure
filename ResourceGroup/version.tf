terraform {
    required_providers {
        azurerm = {
        source  = "hashicorp/azurerm"
        version = "=3.0.0"
        }
    }
    backend "azurerm" {
    resource_group_name   = var.RESOURCE_GROUP_NAME
    storage_account_name  = var.STORAGE_ACCOUNT_NAME
    container_name        = var.CONTAINER_NAME
    key                   = var.KEY
    use_azuread_auth      = true
  }
    required_version = ">= 1.0, <2.0"
}