# Es necesario tener instalado el Azure CLI y estar conectado
# Es necesario tener generarada la clave ssh pública id_rsa.pub

# Inicializar terraform
terraform init

# Crear el plan de la infraestructura
terraform plan

# Crear la infraestructura en Azure
terraform apply --auto-approve