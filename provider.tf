provider "azurerm" {
  features {
  }
  subscription_id                 = "92b5e680-f096-409b-ab88-faa516e81307"
  environment                     = "public"
  use_msi                         = false
  use_cli                         = true
  use_oidc                        = false
  resource_provider_registrations = "none"
}
