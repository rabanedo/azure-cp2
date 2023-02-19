############################################### SECURITY GROUPS RESOURCES ##############################################

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
  security_rule       = var.ssh_security_rule
  security_rule       = var.ic_security_rule
}

# Grupo de Seguridad para la VM worker con la regla para habilitar el ssh
resource "azurerm_network_security_group" "worker" {
  name                = "worker_security"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  security_rule       = var.ssh_security_rule
}

# Grupo de Seguridad para la VM webservice con la regla para habilitar el ssh
resource "azurerm_network_security_group" "webservice" {
  name                = "webservice_vnic_security"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  security_rule       = var.ssh_security_rule
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