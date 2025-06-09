locals {
  namespace = yamldecode(file("namespace.yaml"))
}

inputs = {
  account = local.namespace.account
  namespace = local.namespace.namespace

  custom_tags = {
    maintainer   = local.namespace.maintainer
    organization = local.namespace.organization
    terraform    = local.namespace.terraform
    namespace    = local.namespace.namespace
  }
}

generate "providers" {
  path = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "vsphere" {}
provider "harbor" {}
provider "vault" {}
provider "keycloak" {}
provider "minio" {}
provider "postgresql" {}
provider "random" {}
EOF
}

# this block overwrite required_providers if we have defenition in module or diferent places
# https://developer.hashicorp.com/terraform/language/files/override
# https://stackoverflow.com/questions/66770564/using-terragrunt-generate-provider-block-causes-conflicts-with-require-providers
generate "versions" {
  path      = "versions_override.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    vsphere = {
      source    = "hashicorp/vsphere"
      version   = "2.6.1"
    }
    harbor = {
      source = "goharbor/harbor"
      version = "3.10.8"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.25.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    keycloak = {
      source = "mrparkers/keycloak"
      version = "4.4.0"
    }
    minio = {
      source = "aminueza/minio"
      version = "2.2.0"
    }
    postgresql = {
      source = "cyrilgdn/postgresql"
      version = "1.22.0"
    }
  }
}
EOF
}

remote_state {
  backend = "http"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    address        = "${local.account.gitlab_base_address}/${local.account.gitlab_backend_project_id}/terraform/state/${local.account.account}-${replace(path_relative_to_include(),"/","-")}"
    lock_address   = "${local.account.gitlab_base_address}/${local.account.gitlab_backend_project_id}/terraform/state/${local.account.account}-${replace(path_relative_to_include(),"/","-")}/lock"
    unlock_address = "${local.account.gitlab_base_address}/${local.account.gitlab_backend_project_id}/terraform/state/${local.account.account}-${replace(path_relative_to_include(),"/","-")}/lock"
    lock_method    = "POST"
    unlock_method  = "DELETE"
    retry_wait_min = 5
  }
}