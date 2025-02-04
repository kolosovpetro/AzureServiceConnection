# Azure Service Endpoint

Terraform setup to validate the private connection between an Azure VM and a Blob Storage account. It provisions a
virtual network, subnet, and storage account with a service endpoint, disables public access, and tests connectivity
using CURL and nslookup.

## Terraform Init

- Create and configure Azure Storage Account for Terraform state
- Create `azure.sas.conf` file with the following content:
    ```bash
    storage_account_name = "storage_account_name"
    container_name       = "container_name"
    key                  = "terraform.tfstate"
    sas_token            = "sas_token"
    ```
- `terraform init -backend-config="azure.sas.conf" -reconfigure -upgrade`

## Module referencing

- Bitbucket: `git::git@bitbucket.org:kolosovpetro/terraform.git//modules/storage`
- Github: `git::git@github.com:kolosovpetro/terraform.git//modules/storage`

## Pre-commit configuration

- Install python3 via Windows Store
- `pip install --upgrade pip`
- `pip install pre-commit`
- Update PATH variable
- `pre-commit install`

### Install terraform docs

- `choco install terraform-docs`

### Install tflint

- `choco install tflint`

### Documentation

- https://github.com/antonbabenko/pre-commit-terraform
- https://github.com/kolosovpetro/AzureTerraformBackend
- https://github.com/terraform-docs/terraform-docs
- https://terraform-docs.io/user-guide/installation/
- https://pre-commit.com/

## Storage account configuration file

  ```bash
  storage_account_name = "storage_account_name"
  container_name       = "container_name"
  key                  = "terraform.tfstate"
  sas_token            = "sas_token"
  ```

## Deploy storage account for terraform state

- See [CreateAzureStorageAccount.ps1](./CreateAzureStorageAccount.ps1)
