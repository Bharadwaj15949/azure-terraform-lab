terraform {
  backend "azurerm" {
    resource_group_name  = "my_test_RG"
    storage_account_name = "myteststorageaccount011"
    container_name       = "terraformstate"
    key                  = "existing-infra.tfstate"
    use_azuread_auth     = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.11.0"
    }
  }
}
