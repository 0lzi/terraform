terraform {
  required_version = ">=0.14.0"
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~>3.3.2"
    }
  }

  backend "s3" {
    bucket = "terraform"
    key    = "tfstates/terraform.tfstate"
    # next two options needed as we're not using AWS
    skip_credentials_validation = true
    force_path_style            = true
  }
}

provider "openstack" {
}
