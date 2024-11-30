variable "uniqueIdentifier" {
  type = string
  default = "default"
}
variable "googleProject" {
    type = string
    default="requiredbutmissing"
}

resource "google_sql_database_instance" "sql_instance" {
  name             = "catalogdb-${var.uniqueIdentifier}"
  database_version = "MYSQL_8_0"
  region           = "us-central1"
  project = var.googleProject

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-n1-standard-1"
  }
}