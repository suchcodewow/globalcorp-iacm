// Virtual Machine
variable "vm_name" {
  type = string
}

variable "vm_owner" {
  type = string
}

variable "vm_type" {
  type    = string
  default = "ubuntu-minimal-2210-kinetic-amd64-v20230126"
}
