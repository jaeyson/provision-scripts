terraform {
  required_version = "~> 1.12"
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "2.26.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}
