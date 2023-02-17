################################################## NETWORK RESOURCES ##################################################

# INFO: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
# Definimos la interfaz virtual de red y la asociamos al resource_group
resource "azurerm_virtual_network" "vnet" {
  name                = var.network_name
  address_space       = ["10.0.40.0/24"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# INFO: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
# Definimos la subnet con el rango de IPs que tendrán nuestras VM
# y asociamos la virtual_network creada y el resource_group
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.40.0/27"]
}

# INFO: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
# Definimos la IP pública y la asociamos al resource_group
resource "azurerm_public_ip" "pip" {
  name                = "VIP"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}