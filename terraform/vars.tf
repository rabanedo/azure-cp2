######################################################### VARS #########################################################
# INFO: https://developer.hashicorp.com/terraform/tutorials/configuration-language/variables

# Declaramos el grupo de recursos
variable "resource_group_name" {
  default = "rg-resources"
}

# INFO: https://github.com/claranet/terraform-azurerm-regions/blob/master/REGIONS.md
# Declaramos la región de la infraestructura de azure
variable "location_name" {
  description = "Región de Azure donde se despliega la infraestructura"
  type        = string
  default     = "westeurope"
}

######################################################## VM VARS #######################################################

# INFO: https://docs.microsoft.com/es-es/azure/cloud-services/cloud-services-sizes-specs
# Declaramos la vm master y establecemos sus características (Standard_D2_v3)
# +----------------+-----+---------+-------+-------------+
# |      Size      | CPU | Memoria |  SSD  |  Bandwidth  |
# +----------------+-----+---------+-------+-------------+
# | Standard_D2_v3 |  2  |    8	   | 50GB  | 2/moderado  |
# +----------------+-----+---------+-------+-------------+
variable "master_vm" {
  type        = string
  description = "VM Master [AKS]"
  default     = "Standard_D2_v3"
}

# Declaramos la vm worker/webservice y establecemos sus características (Standard_A2_v2)
# +----------------+-----+---------+-------+-------------+
# |      Size      | CPU | Memoria |  SSD  |  Bandwidth  |
# +----------------+-----+---------+-------+-------------+
# | Standard_A2_v2 |  2  |    4	   | 20GB  | 2/moderado  |
# +----------------+-----+---------+-------+-------------+
variable "standard_vm" {
  type        = string
  description = "VM Standard [Worker/Webservice]"
  default     = "Standard_A2_v2"
}

variable "os_disk" {
  description = "Virtual Machine SSD Type"
  type        = map(string)
  default     = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

# Comando para establecer los valores requeridos en la creación de la máquina virtual:
# az vm image list -f almalinux -p almalinux -s 8-gen1 --all --output table
variable "source_image_reference" {
  description = "Virtual Machine Image Data"
  type        = map(string)
  default     = {
    publisher = "almalinux"
    offer     = "almalinux"
    sku       = "8-gen1"
    version   = "8.7.2022122801"
  }
}

# Comando para establecer los valores requeridos en el plan para este tipo de VM:
# az vm image show --location westeurope --urn almalinux:almalinux:8-gen1:8.7.2022122801
variable "plan" {
  description = "Virtual Machine Image Plan"
  type        = map(string)
  default     = {
    name      = "8-gen1"
    product   = "almalinux"
    publisher = "almalinux"
  }
}

#################################################### CONNECTION VARS ###################################################

# Declaramos el usuario ssh para conectarse
variable "ssh_user" {
  type        = string
  description = "Usuario de conexión ssh"
  default     = "azureuser"
}

# Declaramos el fichero con la clave pública a copiar a nuestras VMs
variable "public_key_path" {
  type        = string
  description = "Path de la clave pública de acceso a las instancias"
  default     = "~/.ssh/id_rsa.pub"
}

##################################################### NETWORK VARS #####################################################

# Declaramos la red (vnet)
variable "network_name" {
  default = "vnet"
}

# Declaramos la subred (subnet)
variable "subnet_name" {
  default = "subnet"
}

# Declaramos la IP pública de la VM master
variable "master_pip_name" {
  default = "master_pip"
}

# Declaramos la interfaz de red de la VM master
variable "master_vnic_name" {
  default = "master_vnic"
}

# Declaramos la IP pública de la VM worker
variable "worker_pip_name" {
  default = "worker_pip"
}

# Declaramos la interfaz de red de la VM worker
variable "worker_vnic_name" {
  default = "worker_vnic"
}

# Declaramos la IP pública de la VM webservice
variable "webservice_pip_name" {
  default = "webservice_pip"
}

# Declaramos la interfaz de red de la VM webservice
variable "webservice_vnic_name" {
  default = "webservice_vnic"
}

#################################################### SECURITY VARS #####################################################

# Declaramos la security_rule para la regla SSH
variable "ssh_security_rule" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [
    {
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
  ]
}

# Declaramos la security_rule para la regla IngressController
variable "ic_security_rule" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [
    {
      name                       = "IngressController"
      priority                   = 1002
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3000-32767"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}
