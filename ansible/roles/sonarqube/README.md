# sonarqube

Role to install and configure a sonarqube in an aks cluster

## Vars

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

## Encrypted vars

- roles/sonarqube/templates
    - data.password:                   The PostgreSQL password in SonarQube secrets template.

## Templates

- roles/sonarqube/templates
    - sonar-data.yml.j2                Default website page with authentication.
    - sonar-deployment.yml.j2
    - sonar-extensions.yml.j2
    - sonar-secret.yml.j2
    - sonar-service.yml.j2

## Dependencies

None.

## License

Apache License Version 2.0             http://www.apache.org/licenses/

## Author Information

This playbook was developed by R2A