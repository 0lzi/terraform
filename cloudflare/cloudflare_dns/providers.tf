terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "5.7.1"
    }
  }
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_token = var.cloudflare_api_token
}
