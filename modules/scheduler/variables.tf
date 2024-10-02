variable "project" {}
variable "name" {}
variable "region" {}
variable "description" {}
variable "schedule" {}
variable "time_zone" {}
variable "attempt_deadline" {}
variable "retry_count" {}
variable "http_method" {}
variable "uri" {}
variable "body" {}
variable "service_account_email" {}
variable "create_count" {
  type    = number
  default = 1
}