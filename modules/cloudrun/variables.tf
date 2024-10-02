variable "project" {}
variable "name" {}
variable "location" {}
variable "image" {}
variable "cpu" {}
variable "memory" {}
variable "percent" {}
variable "latest_revision" {}
# variable "vpc_name" {}
variable "create_count" {
  type    = number
  default = 1
}
