variable "project" {}
variable "name" {}
variable "description" {}
variable "location" {}
variable "runtime" {}
variable "available_memory" {}
variable "bucket" {}
variable "object" {}
variable "max_instance_count" {}
# variable trigger_http {}
#variable https_trigger_securit {}
variable "timeout" { type = number }
variable "entry_point" {}
variable "labels" {
  type        = map(any)
  description = "A set of key/value label pairs to assign to this ManagedZone"
  default     = {}
}

variable "environment_variables" {
  type        = map(any)
  description = "A set of key/value label pairs to assign to this ManagedZone"
  default     = {}
}