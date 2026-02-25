terraform {
  required_version = ">=0.14.0"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "5.0.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.7.1"
    }
  }
  backend "http" {
    address        = "https://${var.GITLAB_HOST}/api/v4/projects/${var.PROJECT_ID}/terraform/state/${var.STATE_NAME}"
    lock_address   = "https://${var.GITLAB_HOST}/api/v4/projects/${var.PROJECT_ID}/terraform/state/${var.STATE_NAME}/lock"
    unlock_address = "https://${var.GITLAB_HOST}/api/v4/projects/${var.PROJECT_ID}/terraform/state/${var.STATE_NAME}/lock"
  }

}

data "vault_generic_secret" "cloudflare" {
  path = "kv/terraform/cloudflare"
}

provider "cloudflare" {
  email     = data.vault_generic_secret.cloudflare.data["cloudflare_email"]
  api_token = data.vault_generic_secret.cloudflare.data["cloudflare_api_token"]
}
