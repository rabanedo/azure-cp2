################################################### GROUP OF VARS #####################################################
# INFO: https://developer.hashicorp.com/terraform/tutorials/configuration-language/variables

# Declaramos la variable del grupo del recurso
variable "resource_group_name" {
  default = "rg-resources"
}

# INFO: https://github.com/claranet/terraform-azurerm-regions/blob/master/REGIONS.md
# Declaramos la variable de la región de la infraestructura de azure
variable "location_name" {
  description = "Región de Azure donde se despliega la infraestructura"
  type = string
  default = "westeurope"
}