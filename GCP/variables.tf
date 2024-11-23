// Define Valid Variables
// Harness Platform
# variable "account_id" {
#   type = string
# }

variable "cluster_name" {
  type = string
}

variable "min_node_count" {
  type = string
  default = 1
}

variable "max_node_count" {
  type = string
  default = 1
}

variable "owner" {
  type = string
}

variable "org_id" {
  type = string
}

variable "project_id" {
  type = string
}

variable "resource_purpose" {
  type = string
  default = "purposemissing"
}

variable "gcp_project_id" {
  type    = string
  default = "sales-209522"
}

variable "gcp_region" {
  type    = string
  default = "us-east1"
}

variable "gcp_zone" {
  type    = string
  default = "us-east1-b"
}

// Cluster & Node Pool

variable "gke_machine_type" {
  type = string
  default="e2-standard-4"
}


// Harness Config
# variable "namespace" {
#   type = string
# }

# variable "api_key" {
#   type      = string
#   sensitive = true
# }

# variable "resource_owner" {
#   type = string
# }