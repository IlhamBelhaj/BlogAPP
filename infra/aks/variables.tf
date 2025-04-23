
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}


variable "prefix" {
  description = "Prefix for the AKS cluster name"
}


variable "agents_max_count" {
  description = "Maximum number of nodes in a pool"
  type        = number
}

variable "agents_min_count" {
  description = "Minimum number of nodes in a pool"
  type        = number
}


