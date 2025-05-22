// Define Valid Variables

// Platform
variable "account_id" {
  type = string
}

variable "org_id" {
  type = string
}

variable "project_id" {
  type = string
}

variable "api_key" {
  type      = string
  sensitive = true
}

// Workspace
variable "workspace_name" {
  type = string
}

variable "workspace_provisioner_type" {
  type    = string
  default = "opentofu"
}

variable "workspace_provisioner_version" {
  type    = string
  default = "1.8.8"
}

variable "workspace_repository_name" {
  type = string
}

variable "workspace_repository_branch" {
  type    = string
  default = "main"
}

variable "workspace_repository_path" {
  type = string
}

variable "workspace_repository_connector" {
  type = string
}

variable "workspace_provider_connector" {
  type = string
}

variable "tf_var_file" {
  type = object({
    conn   = string
    name   = string
    branch = string
    path   = string
  })
  default = null
}

variable "tf_vars" {
  type = list(object({
    key        = string
    value      = string
    value_type = string
  }))
}
