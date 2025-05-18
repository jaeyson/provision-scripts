variable "vultr_api_key" {
  type        = string
  description = "API key for Vultr"
  sensitive   = true
}

variable "vm_plan" {
  type        = string
  description = "VM plan based on region-id"
  default     = null
}

variable "vm_region" {
  type        = string
  description = "The ID of the region that the instance is to be created in."
  default     = null
}

variable "os_id" {
  type        = number
  description = "The ID of the operating system to be installed on the server"
  default     = null
}

variable "snapshot_id" {
  type        = string
  description = "The ID of the Vultr snapshot that the server will restore for the initial installation."
  default     = null
  sensitive   = true
}

variable "image_id" {
  type        = any
  description = "The ID of the Vultr marketplace application to be installed on the server. Note marketplace applications are denoted by type: marketplace and you must use the image_id not the id."
  default     = null
}

variable "is_backups_enabled" {
  type        = string
  description = "Whether automatic backups will be enabled for this server (these have an extra charge associated with them). Values can be enabled or disabled."
  default     = "disabled"
}

variable "vm_label" {
  type        = string
  description = "A label for the server"
  default     = null
}

variable "ssh_key_name" {
  type        = string
  description = "ssh key name found in vps provider"
  sensitive   = true
}

variable "ssh_key_path" {
  type        = string
  description = "path to ssh pub key"
  sensitive   = true
}

variable "vm_hostname" {
  type        = string
  description = "The hostname to assign to the server"
}
