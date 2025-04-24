terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.117.0"
    }
  }
}

provider "azurerm" {
  resource_provider_registrations = "none"
  features {}
  subscription_id = "f75c69e9-2ee8-4632-bdc1-fc29f62ce9d7"

}

resource "azurerm_virtual_machine" "monitoring" {
  name                  = "Monitoring"
  location              = "West Europe"
  resource_group_name   = "Ilham"
  network_interface_ids = []
  vm_size               = "Standard_B1s"
}
