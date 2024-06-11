terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.52.0"
    }
    aviatrix = {
      source  = "aviatrixsystems/aviatrix"
      version = "3.1.4"
    }
    equinix = {
      source = "equinix/equinix"
    }
  }
}
