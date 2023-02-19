############################################# VIRTUAL MACHINES RESOURCES ##############################################

# INFO: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
# Definimos el grupo de recursos donde estaran asociados todos recursos que necesitemos crear
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location_name
}

# INFO:  https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
# Definimos la máquina virtual master del AKS con todos los recursos necesarios
resource "azurerm_linux_virtual_machine" "master" {
  name                  = "master_vm"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = var.master_vm
  admin_username        = var.ssh_user
  network_interface_ids = [
    azurerm_network_interface.master_vnic.id
  ]

  admin_ssh_key {
    username   = var.ssh_user
    public_key = file(var.public_key_path)
  }

  os_disk                = var.os_disk
  plan                   = var.plan
  source_image_reference = var.source_image_reference
}

# Definimos la máquina virtual worker del AKS con todos los recursos necesarios
resource "azurerm_linux_virtual_machine" "worker" {
  name                  = "worker_vm"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = var.standard_vm
  admin_username        = var.ssh_user
  network_interface_ids = [
    azurerm_network_interface.worker_vnic.id
  ]

  admin_ssh_key {
    username   = var.ssh_user
    public_key = file(var.public_key_path)
  }

  os_disk                = var.os_disk
  plan                   = var.plan
  source_image_reference = var.source_image_reference
}

# Definimos la máquina virtual webservice con todos los recursos necesarios
resource "azurerm_linux_virtual_machine" "webservice" {
  name                  = "webservice_vm"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = var.standard_vm
  admin_username        = var.ssh_user
  network_interface_ids = [
    azurerm_network_interface.webservice_vnic.id
  ]

  admin_ssh_key {
    username   = var.ssh_user
    public_key = file(var.public_key_path)
  }

  os_disk                = var.os_disk
  plan                   = var.plan
  source_image_reference = var.source_image_reference
}