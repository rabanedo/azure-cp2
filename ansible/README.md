# Playbook to deploy AKS + WS + ACR (Practical Case II)

## Structure

The playbook has the following structure:

- playbook_ansible.yml                 Playbook to install ansible-galaxy collection community.general for ansible.
- playbook_galaxy.yml                  Playbook to install galaxy collections for ansible.
- playbook_ws_aks.yml                  Playbook to install the webservices, postgres database and sonarqube.

- environments
    - development                      Development environment.
    - production                       Production environment.

- global_vars
    - tf_ansible_vars.yml:             Outputs vars from Terraform.
        - tf_webservice_pip:           Public webservice IP.
        - tf_acr_password:             Azure container registry (ACR) pasword.

- roles
    - webservice                       Deploy a basic webservice with a podman http container.
    - postgresql                       Deploy a postgresql database for SonarQube.
    - sonarqube                        Deploy SonarQube in a Azure AKS.

## Vars

- roles/postgresql/defaults
    - postgres_packages:               List of necessary postgres packages.
    - db_user:                         Default username.
    - db_password:                     Default password.
    - db_name:                         Default database.

- roles/postgresql/vars
    - db_user:                         PostgreSQL username for SonarQube.
    - db_password:                     PostgreSQL password for SonarQube.
    - db_name:                         PostgreSQL database name for SonarQube.

- roles/sonarqube/defaults
    - k8s_path:                        Path in which k8s deploy.
    - kube_config_path:                Path kube config.
    - kube_config_temp:                Temporary path for kube config.

- roles/sonarqube/vars
    - apt_packages:                    APT packages necessary to images (SonarQube).
    - pip_packages:                    Python necessary packages for k8s.
    - k8s_templates:                   Template k8s' name *.yaml.
    - acr_url:                         URL for Azure Container Registry (ACR).
    - tag_image:                       Tag for container image.
    - k8s_namespace:                   The k8s namespace.
    - deployment:                      The k8s Deployment yaml vars.
    - svc:                             The k8s Service yaml vars.
    - pvc:                             The k8s PersistentVolumeClaim yaml vars.

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
    - sq_path:                         Path in which SonarQube image.
    - sonarqube_image:                 SonarQube image for AKS.

- roles/webservice/vars
    - ws_packages:                     Packages necessary to install.
    - username:                        Username webservice access.
    - password:                        Password webservice access.
    - key_type:                        The algorithm used to generate the TLS/SSL private key.
    - acr_url:                         URL for Container Registry ACR.
    - acr_username:                    Username for Container Registry ACR.
    - acr_password:                    Password for ACR.

## Encrypted vars

- roles/sonarqube/templates
    - data.password:                   The PostgreSQL password in SonarQube secrets template.

## Handlers

- roles/postgresql/handlers
    - Restart PostgreSQL.              Handler for restart postgres database service.

## Files

- roles/webservice/files
    - index.html                       Default website page within authentication.

## Templates

- roles/sonarqube/templates
    - sonar-data.yml.j2                Default website page with authentication.
    - sonar-deployment.yml.j2
    - sonar-extensions.yml.j2
    - sonar-secret.yml.j2
    - sonar-service.yml.j2

- roles/webservice/templates
    - .htaccess.j2                     Default website page with authentication.
    - Containerfile.j2
    - httpd.conf.j2

## Example Playbook

```
    - hosts: webservice
      roles:
          - { role: webservice }
```

## License

Apache License Version 2.0             http://www.apache.org/licenses/

## Author Information

This playbook was developed by R2A