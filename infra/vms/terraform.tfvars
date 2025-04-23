address_space       = ["10.0.0.0/16"]
location            = "westeurope"
resource_group_name = "Ilham"

cidrs                = ["10.0.1.0/24"]
client_name          = "ilham_cn"
environment          = "test"
location_short       = "westeurope"
stack                = "int"
virtual_network_name = "my-vnet"
subnet_name          = "my-subnet"

image_os = "linux"
# vm_name = "my-vm"

vm_size = "Standard_DS1_v2"

os_disk = {
  caching              = "ReadWrite"
  storage_account_type = "Standard_LRS"
  disk_size_gb         = 30
}

source_image_reference = {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-jammy"
  sku       = "22_04-lts"
  version   = "latest"
}
