# webservice

Role to configure a podman image in a webserver

## Requirements

- global_vars
    - tf_ansible_vars.yml:             Outputs vars from Terraform.

## Vars

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

## Files

- roles/webservice/files
    - index.html                       Default website page within authentication.

## Templates

- roles/webservice/templates
    - .htaccess.j2                     Default website page with authentication.
    - Containerfile.j2
    - httpd.conf.j2

## Dependencies

None.

## License

Apache License Version 2.0             http://www.apache.org/licenses/

## Author Information

This playbook was developed by R2A