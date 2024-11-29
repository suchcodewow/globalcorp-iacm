variable "uniqueIdentifier" {
  type = string
  default = "default"
}
variable "googleProject" {
    type = string
    default="requiredbutmissing"
}

resource "google_sql_database_instance" "main" {
  name             = "catalogdb-${var.uniqueIdentifier}"
  database_version = "MYSQL_8_0"
  region           = "us-east1"
  project = var.googleProject

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-f1-micro"
  }
}