###################################################### RESOURCES #######################################################

# INFO: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
# Definimos el cluster de kubernetes AKS con todos los recursos necesarios
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = var.aks_node_pool
    node_count = 1
    vm_size    = var.cluster_aks
  }

  linux_profile {
    admin_username = var.ssh_user
    ssh_key {
      key_data = file(var.public_key_path)
    }
  }

  network_profile {
    network_plugin    = var.aks_network_plugin
    load_balancer_sku = var.aks_lb_sku
  }

  identity {
    type = var.aks_identity
  }
}

# INFO: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
# Definimos la máquina virtual webservice con todos los recursos necesarios
resource "azurerm_linux_virtual_machine" "webservice" {
  name                  = "webservice"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = var.webservice_vm
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

# INFO: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry
# Definimos el registry donde almacenar las imagenes con todos los recursos necesarios
resource "azurerm_container_registry" "acr" {
  name                = "rraContainerRegistry"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = var.acr_sku
  admin_enabled       = true
}