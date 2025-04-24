module "avm-res-network-virtualnetwork" {
  source              = "Azure/avm-res-network-virtualnetwork/azurerm"
  version             = "0.8.1"
  name                = var.virtual_network_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "subnet" {
  source               = "claranet/subnet/azurerm"
  version              = "8.0.1"
  cidrs                = var.cidrs
  client_name          = var.client_name
  environment          = var.environment
  location_short       = var.location_short
  resource_group_name  = var.resource_group_name
  stack                = var.stack
  virtual_network_name = module.avm-res-network-virtualnetwork.name
}

resource "azurerm_public_ip" "public_ip" {
  count               = 3
  name                = "${var.vm_names[count.index]}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}


module "virtual-machine" {
  source                 = "Azure/virtual-machine/azurerm"
  version                = "2.0.0"
  name                   = var.vm_names[count.index]
  image_os               = var.image_os
  location               = var.location
  resource_group_name    = var.resource_group_name
  size                   = var.vm_size
  subnet_id              = module.subnet.id
  source_image_reference = var.source_image_reference
  count                  = 3

  os_disk = {
    caching              = var.os_disk.caching
    disk_size_gb         = var.os_disk.disk_size_gb
    storage_account_type = var.os_disk.storage_account_type
    name                 = "${var.vm_names[count.index]}-os-disk"
  }

  admin_ssh_keys = [
    {
      public_key = file("C:/Users/ibelhaj/.ssh/id_rsa.pub")
      username   = "azureuser"
    }
  ]

  new_network_interface = {
    name = "${var.vm_names[count.index]}-nic"
    ip_configurations = [
      {
        name                          = "${var.vm_names[count.index]}-ip-config"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.public_ip[count.index].id
      }
    ]
  }

}

output "public_ips" {
  value = azurerm_public_ip.public_ip[*].ip_address
}



