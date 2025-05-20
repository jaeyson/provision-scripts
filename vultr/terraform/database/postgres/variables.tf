variable "api_key" {
  type        = string
  description = "API key for Vultr"
  sensitive   = true
}

variable "database_engine" {
  type        = string
  description = "The database engine of the new managed database."
}

variable "database_engine_version" {
  type        = number
  description = "The database engine version of the new managed database."
}

variable "region" {
  type        = string
  description = "The ID of the region that the managed database is to be created in."
}

variable "plan" {
  type        = string
  description = "The ID of the plan that you want the managed database to subscribe to."
}

variable "label" {
  type        = string
  description = "A label for the managed database."
}

variable "cluster_time_zone" {
  type        = string
  description = "The configured time zone for the Managed Database in TZ database format (e.g. UTC, America/New_York, Europe/London)."
}
