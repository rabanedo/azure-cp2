# Playbook to install galaxy collections for ansible.
ansible-playbook -i hosts playbook_ansible.yml -v

# Playbook to install galaxy collections for ansible.
ansible-playbook -i hosts playbook_galaxy.yml -v

# Playbook for install the Webserver, SonarQube in Azure AKS and PostgreSQL like database.
ansible-playbook -i hosts playbook_ws_aks.yml -v