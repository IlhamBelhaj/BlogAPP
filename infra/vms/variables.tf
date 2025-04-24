variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "location" {
  description = "The Azure region"
  type        = string
}



variable "cidrs" {
  description = "CIDR blocks for the subnet"
  type        = list(string)
}

variable "client_name" {
  description = "The name of the client"
  type        = string
}

variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
    disk_size_gb         = number
  })
  description = "OS disk configuration"

}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "environment" {
  description = "The environment for the resources"
  type        = string
}

variable "location_short" {
  description = "The short location code for the Azure region"
  type        = string
}

variable "stack" {
  description = "The name of the stack/environment"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "image_os" {
  description = "The OS image to use for the virtual machine"
  type        = string
}

variable "vm_names" {
  type        = list(string)
  description = "List of names for the virtual machines"
  default     = ["Nexus", "SonarQube", "Jenkins"]
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
}

variable "source_image_reference" {
  description = "The reference to a marketplace image."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}





