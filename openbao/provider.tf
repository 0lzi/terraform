terraform {
  required_version = ">= 1.9.0"
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "5.0.0"
    }
  }
  backend "http" {
    address        = "https://${var.GITLAB_HOST}/api/v4/projects/${var.PROJECT_ID}/terraform/state/${var.STATE_NAME}"
    lock_address   = "https://${var.GITLAB_HOST}/api/v4/projects/${var.PROJECT_ID}/terraform/state/${var.STATE_NAME}/lock"
    unlock_address = "https://${var.GITLAB_HOST}/api/v4/projects/${var.PROJECT_ID}/terraform/state/${var.STATE_NAME}/lock"
  }
}

