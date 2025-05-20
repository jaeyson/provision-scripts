provider "vultr" {
  api_key     = var.api_key
  rate_limit  = 500
  retry_limit = 3
}

resource "vultr_database" "staging" {
  database_engine         = var.database_engine
  database_engine_version = var.database_engine_version
  region                  = var.region
  plan                    = var.plan
  label                   = var.label
  cluster_time_zone       = var.cluster_time_zone # Seattle also uses pacific tz
  # maintenance_dow = "sunday"
  # maintenance_time = "01:00"
}
