resource "random_pet" "instance" {
  count  = var.label == null ? 1 : 0
  length = 2
}

provider "vultr" {
  api_key     = var.api_key
  rate_limit  = 500
  retry_limit = 3
}

resource "vultr_instance" "web" {
  count  = 1
  plan   = var.plan
  region = var.region
  # image_id    = var.image_id
  # os_id       = var.os_id
  firewall_group_id = var.firewall_group_id
  label             = var.label == null ? random_pet.instance[0].id : var.label
  hostname          = var.hostname
  backups           = var.is_backups_enabled
  snapshot_id       = var.snapshot_id
  ssh_key_ids = [
    vultr_ssh_key.ssh_key.id
  ]
}

resource "vultr_ssh_key" "ssh_key" {
  name    = var.ssh_key_name
  ssh_key = file(var.ssh_key_path)
}

