terraform {
  required_version = ">=0.14.0"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "5.0.0"
    }
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "1.85.3"
    }
  }
}
