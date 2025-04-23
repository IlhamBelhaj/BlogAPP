module "aks" {
  source              = "Azure/aks/azurerm"
  version             = "9.4.0"
  prefix              = var.prefix
  resource_group_name = var.resource_group_name
  agents_max_count    = var.agents_max_count
  agents_min_count    = var.agents_min_count

}
