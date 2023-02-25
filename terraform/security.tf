############################################### SECURITY GROUPS RESOURCES ##############################################

# INFO: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
# Definimos el grupo de recursos donde estaran asociados todos recursos que necesitemos crear
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location_name
}

# Definimos los grupos de seguridad para limitar el acceso y los puertos necesarios a utilizar

# INFO: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
# Definimos el grupo de seguridad para la VM master con dos reglas:
#   + SSH
#   + IngressController
# para poder acceder a la aplicación desde el exterior a Azure
resource "azurerm_network_security_group" "master" {
  name                = "master_security"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dynamic "security_rule" {
    for_each = var.security_rule_conf
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

# Grupo de Seguridad para la VM worker con la regla para habilitar el ssh
resource "azurerm_network_security_group" "worker" {
  name                = "worker_security"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


# Grupo de Seguridad para la VM webservice con la regla para habilitar el ssh
resource "azurerm_network_security_group" "webservice" {
  name                = "webservice_vnic_security"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# INFO: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association
# Asociamos el grupo de seguridad a cada interfaz de red de cada máquina
resource "azurerm_network_interface_security_group_association" "master" {
  network_interface_id      = azurerm_network_interface.master_vnic.id
  network_security_group_id = azurerm_network_security_group.master.id
}

resource "azurerm_network_interface_security_group_association" "worker" {
  network_interface_id      = azurerm_network_interface.worker_vnic.id
  network_security_group_id = azurerm_network_security_group.worker.id
}

resource "azurerm_network_interface_security_group_association" "nfs" {
  network_interface_id      = azurerm_network_interface.webservice_vnic.id
  network_security_group_id = azurerm_network_security_group.webservice.id
}