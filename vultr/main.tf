resource "random_pet" "instance" {
  count  = var.vm_label == null ? 1 : 0
  length = 2
}

provider "vultr" {
  api_key     = var.vultr_api_key
  rate_limit  = 500
  retry_limit = 3
}

resource "vultr_instance" "web" {
  count    = 1
  plan     = var.vm_plan
  region   = var.vm_region
  image_id = var.image_id
  label    = var.vm_label == null ? random_pet.instance[0].id : var.vm_label
  hostname = var.vm_hostname
  backups  = var.is_backups_enabled
  ssh_key_ids = [
    vultr_ssh_key.ssh_key.id
  ]
}

resource "vultr_ssh_key" "ssh_key" {
  name    = var.ssh_key_name
  ssh_key = file(var.ssh_key_path)
}

