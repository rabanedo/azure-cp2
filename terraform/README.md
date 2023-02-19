# Terraform

https://github.com/Azure/azure-cli/blob/dev/README.md

https://developer.hashicorp.com/terraform/language/values/variables#list
https://learn.microsoft.com/es-es/cli/azure/vm/image?source=recommendations&view=azure-cli-latest
https://learn.microsoft.com/en-us/azure/virtual-machines/linux/cli-ps-findimage
https://learn.microsoft.com/es-es/cli/azure/vm/image?view=azure-cli-latest

https://developer.hashicorp.com/terraform/cli/install/apt#repository-configuration
https://www.hashicorp.com/official-packaging-guide

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update
sudo apt install terraform

