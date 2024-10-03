variable "project" {
  description = "The ID of the project where this VPC will be created"
}

variable "googleapis_list" {
  description = "The list of apis necessary for the project"
  type        = list(string)
  default = [
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com"
  ]
}
variable "create_count" {
  type    = number
  default = 1
}
variable "service" {}