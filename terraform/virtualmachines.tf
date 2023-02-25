############################################# VIRTUAL MACHINES RESOURCES ##############################################

# INFO:  https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
# Definimos la máquina virtual master del AKS con todos los recursos necesarios
resource "azurerm_linux_virtual_machine" "master" {
  name                  = "master-vm"
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

  os_disk {
    caching              = var.os_disk_specs.caching
    storage_account_type = var.os_disk_specs.storage_account_type
  }

  plan {
    name      = var.os_image_specs.name
    product   = var.os_image_specs.product
    publisher = var.os_image_specs.publisher
  }

  source_image_reference {
    publisher = var.os_image_specs.publisher
    offer     = var.os_image_specs.offer
    sku       = var.os_image_specs.sku
    version   = var.os_image_specs.version
  }
}

# Definimos la máquina virtual worker del AKS con todos los recursos necesarios
resource "azurerm_linux_virtual_machine" "worker" {
  name                  = "worker-vm"
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

  os_disk {
    caching              = var.os_disk_specs.caching
    storage_account_type = var.os_disk_specs.storage_account_type
  }

  plan {
    name      = var.os_image_specs.name
    product   = var.os_image_specs.product
    publisher = var.os_image_specs.publisher
  }

  source_image_reference {
    publisher = var.os_image_specs.publisher
    offer     = var.os_image_specs.offer
    sku       = var.os_image_specs.sku
    version   = var.os_image_specs.version
  }
}

# Definimos la máquina virtual webservice con todos los recursos necesarios
resource "azurerm_linux_virtual_machine" "webservice" {
  name                  = "webservice-vm"
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

  os_disk {
    caching              = var.os_disk_specs.caching
    storage_account_type = var.os_disk_specs.storage_account_type
  }

  plan {
    name      = var.os_image_specs.name
    product   = var.os_image_specs.product
    publisher = var.os_image_specs.publisher
  }

  source_image_reference {
    publisher = var.os_image_specs.publisher
    offer     = var.os_image_specs.offer
    sku       = var.os_image_specs.sku
    version   = var.os_image_specs.version
  }
}