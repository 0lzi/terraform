terraform {
  required_version = ">=0.14.0"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "5.0.0"
    }
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "1.99.1"
    }
  }
  backend "http" {
    address        = "https://${var.GITLAB_HOST}/api/v4/projects/${var.PROJECT_ID}/terraform/state/${var.STATE_NAME}"
    lock_address   = "https://${var.GITLAB_HOST}/api/v4/projects/${var.PROJECT_ID}/terraform/state/${var.STATE_NAME}/lock"
    unlock_address = "https://${var.GITLAB_HOST}/api/v4/projects/${var.PROJECT_ID}/terraform/state/${var.STATE_NAME}/lock"
  }
}

data "vault_generic_secret" "routeros" {
  path = "kv/terraform/routeros"
}

provider "routeros" {
  hosturl  = data.vault_generic_secret.routeros.data["mikrotik_host_url"]
  username = data.vault_generic_secret.routeros.data["mikrotik_username"]
  password = data.vault_generic_secret.routeros.data["mikrotik_password"]
  insecure = true
}
