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

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  #Creamos el plan para este tipo de máquinas
  plan {
    name      = ""
    product   = ""
    publisher = ""
  }
  # Comando para identificar los valores a poner en la creacción de nuestras máquinas virtuales:
  # az vm image list -f DISTRO -p PUBLISHER --all --output table
  source_image_reference {
    publisher = ""
    offer     = ""
    sku       = ""
    version   = ""
  }
}

## EXAMPLE CODE DELETE ##
resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}