# postgresql

Role to install and configure a postgresql database for our aks cluster

## Requirements

- global_vars
    - tf_ansible_vars.yml:             Outputs vars from Terraform.

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

## Handlers

- roles/postgresql/handlers
    - Restart PostgreSQL.              Handler for restart postgres database service.

## Dependencies

None.

## License

Apache License Version 2.0             http://www.apache.org/licenses/

## Author Information

This role was developed by R2A