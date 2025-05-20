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
  mysql_sql_modes = [
    "ERROR_FOR_DIVISION_BY_ZERO",
    "NO_ENGINE_SUBSTITUTION",
    "STRICT_TRANS_TABLES",
    "ONLY_FULL_GROUP_BY",
    "NO_ZERO_DATE",
    "NO_ZERO_IN_DATE"
  ]
  # maintenance_dow = "sunday"
  # maintenance_time = "01:00"
}
