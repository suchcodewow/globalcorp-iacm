output "instancename" {
  value = google_sql_database_instance.sql_instance.connection_name
}
output "database" {
  value = google_sql_database.database.name
}

variable "uniqueIdentifier" {
  type = string
  default = "default"
}
variable "googleProject" {
    type = string
    default="requiredbutmissing"
}
variable "googleRegion" {
    type = string
    default="requiredbutmissing"
}
variable "databaseTier" {
    type = string
    default="db-n1-standard-1"
}
variable "databaseName" {
    type = string
    default="primaryDatabase"
}

resource "google_sql_user" "users" {
  name     = "api"
  instance = google_sql_database_instance.sql_instance.name
  password = "password"
  project = var.googleProject
  deletion_policy = "ABANDON"
}

# Main Database
resource "google_sql_database" "database" {
  name     = var.databaseName
  instance = google_sql_database_instance.sql_instance.name
  project = var.googleProject
  deletion_policy = "ABANDON"
}
# On-demand databases
resource "google_sql_database" "database" {
  name     = "silver"
  instance = google_sql_database_instance.sql_instance.name
  project = var.googleProject
  deletion_policy = "ABANDON"
}
resource "google_sql_database" "database" {
  name     = "gray"
  instance = google_sql_database_instance.sql_instance.name
  project = var.googleProject
  deletion_policy = "ABANDON"
}

resource "google_sql_database" "database" {
  name     = var.databaseName
  instance = google_sql_database_instance.sql_instance.name
  project = var.googleProject
  deletion_policy = "ABANDON"
}

resource "google_sql_database_instance" "sql_instance" {
  name             = var.uniqueIdentifier
  database_version = "MYSQL_8_0"
  region           = var.googleRegion
  project = var.googleProject
  deletion_protection = false

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = var.databaseTier
    
  }
}