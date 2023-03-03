# Playbook to deploy AKS + WS +ACR (Practical  Case II)

## Structure

The playbook has the following structure:

- playbook.yml

- environments
    - development:                     Development environment.
    - production:                      Production environment.

- global_vars

- roles
    - upgrade_host:                    Upgrade SO & packages.
    - webservice:                      Deploy a basic webservice with a podman http container.

## Global vars

## Vars

- roles/upgrade_host/vars
    - ansible_collection:              List of necessary collections.

- roles/upgrade_host/vars
    - ansible_collection:              List of necessary collections.

- roles/webservice/defaults
    - username:                        Default username.
    - password:                        Default password.
    - webserver_path:                  Path in which webserver.
    - server_container_path:           Server container path.
    - server_hostname:                 File in which the generated TLS/SSL private key.
    - key_size:                        Size (in bits) of the TLS/SSL key to generate.
    - passphrase:                      The passphrase for the private key.
    - key_type:                        Default algorithm used to generate the TLS/SSL private key.
    - container_files:                 Configuration container files.
        - src_path
        - file_name
    - container_templates:             Configuration container templates.
        - src_path
        - file_name
    - podman_image:                    Name for container image.
    - tag_image:                       Tag for container image.
    - container_web_service:           Path for container systemd service.
    - container_prefix:                Container systemd service name.
    - acr_url:                         URL for ACR.
    - acr_username:                    Username for ACR.
    - acr_password:                    Password for ACR.

- roles/webservice/defaults
    - packages:                        Packages necessary to install.
    - username:                        Username webservice access.
    - password:                        Password webservice access.
    - key_type:                        The algorithm used to generate the TLS/SSL private key.
    - acr_url:                         URL for Container Registry ACR.
    - acr_username:                    Username for Container Registry ACR.
    - acr_password:                    Password for ACR.

## Encrypted files