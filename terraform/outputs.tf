################################################### OUTPUT VARS #######################################################

# Declaramos como variable de salida el grupo de recursos
output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

# Declaramos como variable de salida la VM master
output "master_id" {
  value = azurerm_linux_virtual_machine.master.id
}

# Declaramos como variable de salida la VM worker
output "worker_id" {
  value = azurerm_linux_virtual_machine.worker.id
}