variable "api_key" {
  type        = string
  description = "API key for Vultr"
  sensitive   = true
}

variable "os_id" {
  type        = number
  description = "The id of the os to use. This will be the OS that will be used to launch a new instance and provision it."
}

# variable "image_id" {
#   type        = string
#   description = "The ID of the Vultr marketplace application to be installed on the server. Note marketplace applications are denoted by type: marketplace and you must use the image_id not the id."
# }

variable "region_id" {
  type        = string
  description = "The ID of the region that the instance is to be created in."
}

variable "plan_id" {
  type        = string
  description = "The id of the plan you wish to use. See List Plans: https://www.vultr.com/api/v2/#tag/plans"
}

variable "ssh_key_path" {
  type        = string
  description = "SSH pub key path"
}
packer {
  required_plugins {
    vultr = {
      version = ">=v2.3.2"
      source  = "github.com/vultr/vultr"
    }
    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "vultr" "base" {
  api_key   = var.api_key
  plan_id   = var.plan_id
  region_id = var.region_id
  os_id     = var.os_id
  # image_id             = var.image_id
  snapshot_description = "Packer Base ${formatdate("YYYY-MM-DD hh:mm:ss", timestamp())}"
  ssh_username         = "root"
  state_timeout        = "15m"
}

build {
  sources = ["source.vultr.base"]

  provisioner "ansible" {
    playbook_file = "../ansible/playbook.yml"
    # ssh_authorized_key_file = var.ssh_key_path
    # ssh_host_key_file       = "/path/to/.ssh/id_ed25519"
    user             = "root"
    ansible_env_vars = ["ANSIBLE_HOST_KEY_CHECKING=False"]
    empty_groups     = ["PACKER_EMPTY_GROUP"]
    # extra_arguments         = ["--private-key", file("/path/to/.ssh/id_ed25519")]
    groups     = ["PACKER_BASE"]
    host_alias = "packer-base"
  }

  provisioner "shell" {
    expect_disconnect = true

    inline = [
      # "sudo reboot now",
      "reboot now",
    ]

    pause_before = "5s"
    pause_after  = "10s"
  }
}
