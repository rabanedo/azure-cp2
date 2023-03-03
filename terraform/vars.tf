######################################################### VARS #########################################################
# INFO: https://developer.hashicorp.com/terraform/tutorials/configuration-language/variables

# Declaramos el grupo de recursos
variable "resource_group_name" {
  default = "rg-resources"
}

# INFO: https://github.com/claranet/terraform-azurerm-regions/blob/master/REGIONS.md
# Declaramos la región de la infraestructura de azure
variable "location_name" {
  description = "Azure region where the infrastructure is deployed"
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
variable "cluster_aks" {
  type        = string
  description = "Cluster AKS"
  default     = "Standard_D2_v3"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix specified when creating the managed cluster"
  default     = "aks-rra-cp2"
}

variable "aks_node_pool" {
  type        = string
  description = "The name which should be used for the default Kubernetes Node Pool"
  default     = "nodepool"
}

variable "aks_network_plugin" {
  type        = string
  description = "Network plugin to use for networking"
  default     = "kubenet"
}

variable "aks_lb_sku" {
  type        = string
  description = "Specifies the SKU of the Load Balancer used for this Kubernetes Cluster"
  default     = "standard"
}

variable "aks_identity" {
  type        = string
  description = "Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster"
  default     = "SystemAssigned"
}

# Declaramos la vm webservice y establecemos sus características (Standard_A2_v2)
# +----------------+-----+---------+-------+-------------+
# |      Size      | CPU | Memoria |  SSD  |  Bandwidth  |
# +----------------+-----+---------+-------+-------------+
# | Standard_A2_v2 |  2  |    4	   | 20GB  | 2/moderado  |
# +----------------+-----+---------+-------+-------------+
variable "webservice_vm" {
  type        = string
  description = "VM Webservice"
  default     = "Standard_A2_v2"
}

variable "os_disk_specs" {
  description = "Virtual Machine SSD Specs"
  type        = map(string)
  default     = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

# Comando para establecer los valores requeridos en la creación de la máquina virtual:
# az vm image list -f almalinux -p almalinux -s 8-gen1 --all --output table
# Comando para establecer los valores requeridos en el plan para este tipo de VM:
# az vm image show --location westeurope --urn almalinux:almalinux:8-gen1:8.7.2022122801
variable "os_image_specs" {
  description = "Virtual Machine Image Specs"
  type        = map(string)
  default     = {
    name      = "8-gen1"
    product   = "almalinux"
    publisher = "almalinux"
    offer     = "almalinux"
    sku       = "8-gen1"
    version   = "8.7.2022122801"
  }
}

# Declaramos el SKU del container registry ACR
variable "acr_sku" {
  type        = string
  description = "The SKU value of the container registry"
  default     = "Basic"
}

#################################################### CONNECTION VARS ###################################################

# Declaramos el usuario ssh para conectarse
variable "ssh_user" {
  type        = string
  description = "SSH connection user"
  default     = "azureuser"
}

# Declaramos el fichero con la clave pública a copiar a nuestras VMs
variable "public_key_path" {
  type        = string
  description = "Public key path to access the instances"
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

# Declaramos la IP pública de la VM webservice
variable "webservice_pip_name" {
  default = "webservice-pip"
}

# Declaramos la interfaz de red de la VM webservice
variable "webservice_vnic_name" {
  default = "webservice-vnic"
}

#################################################### SECURITY VARS #####################################################

# Declaramos la security_rule_conf para ssh/http
variable "webservice_security_rule_conf" {
  default = {
    "SSH Security Rule" = {
      name                   = "ssh"
      priority               = 1002
      destination_port_range = "22"
    },
    "IngressController Security Rule" = {
      name                   = "http"
      priority               = 1003
      destination_port_range = "8080"
    }
  }
}

# Declaramos el role_definition_name
variable "role_definition" {
  default     = "AcrPull"
}
