variable "api_key" {
  type        = string
  description = "API key for Vultr"
  sensitive   = true
}

variable "image_id" {
  type        = string
  description = "The ID of the Vultr marketplace application to be installed on the server. Note marketplace applications are denoted by type: marketplace and you must use the image_id not the id."
}

variable "region_id" {
  type        = string
  description = "The ID of the region that the instance is to be created in."
}

variable "plan_id" {
  type        = string
  description = "The id of the plan you wish to use. See List Plans: https://www.vultr.com/api/v2/#tag/plans"
}

packer {
  required_plugins {
    vultr = {
      version = ">=v2.3.2"
      source  = "github.com/vultr/vultr"
    }
    # ansible = {
    #   version = "~> 1"
    #   source = "github.com/hashicorp/ansible"
    # }
  }
}

source "vultr" "base" {
  api_key              = var.api_key
  plan_id              = var.plan_id
  region_id            = var.region_id
  image_id             = var.image_id
  snapshot_description = "Packer Base ${formatdate("YYYY-MM-DD hh:mm:ss", timestamp())}"
  ssh_username         = "root"
  state_timeout        = "45m"
}

build {
  sources = ["source.vultr.base"]

  # provisioner "file" {
  #   source      = "../helper-scripts/vultr-helper.sh"
  #   destination = "/root/vultr-helper.sh"
  # }

  # provisioner "shell" {
  #   script        = "packer-example.sh"
  #   remote_folder = "/root"
  #   remote_file   = "packer-example.sh"
  # }
}
