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
