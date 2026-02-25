terraform {
  required_version = ">=0.14.0"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "5.0.0"
    }
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc06"
    }
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "1.85.3"
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

data "vault_generic_secret" "proxmox" {
  path = "kv/terraform/proxmox"
}

provider "proxmox" {
  pm_api_url          = "https://pve1.0lzi.com:8006/api2/json"
  pm_api_token_id     = data.vault_generic_secret.proxmox.data["PM_API_TOKEN_ID"]
  pm_api_token_secret = data.vault_generic_secret.proxmox.data["PM_API_TOKEN_SECRET"]
}

provider "routeros" {
  hosturl  = data.vault_generic_secret.routeros.data["mikrotik_host_url"]
  username = data.vault_generic_secret.routeros.data["mikrotik_username"]
  password = data.vault_generic_secret.routeros.data["mikrotik_password"]
  insecure = true
}
