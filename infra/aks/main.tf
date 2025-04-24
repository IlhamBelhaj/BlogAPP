terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.117.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "f75c69e9-2ee8-4632-bdc1-fc29f62ce9d7"

}


resource "azurerm_kubernetes_cluster" "aks-cluster" {
  name                = "ilham-aks-cluster"
  location            = "West Europe"
  resource_group_name = "ilham"
  dns_prefix          = "ilham-aks"
  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}
