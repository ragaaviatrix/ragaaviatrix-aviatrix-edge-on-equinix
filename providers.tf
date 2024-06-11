terraform {
  required_providers {
    equinix = {
      source = "equinix/equinix"
    }
    aviatrix = {
      source  = "aviatrixsystems/aviatrix"
      version = "3.1.4"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "useast1"
}

provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}


provider "aviatrix" {
  controller_ip = var.controller_ip
  username      = var.controller_username
  password      = var.controller_password
}