resource "random_pet" "instance" {
  count  = var.label == null ? 1 : 0
  length = 2
}

provider "vultr" {
  api_key     = var.api_key
  rate_limit  = 500
  retry_limit = 3
}

resource "vultr_instance" "imgproxy" {
  count    = 1
  plan     = var.plan
  region   = var.region
  image_id = var.image_id
  label    = var.label == null ? random_pet.instance[0].id : var.label
  hostname = var.hostname
  backups  = var.is_backups_enabled
  ssh_key_ids = [
    data.vultr_ssh_key.ssh_key.id
  ]
}

data "vultr_ssh_key" "ssh_key" {
  filter {
    name = "name"
    values = [
      var.ssh_key_name
    ]
  }
}

