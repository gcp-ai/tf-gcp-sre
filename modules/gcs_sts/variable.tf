variable "project" {}
variable "description" {}
variable "source_bucket" {}
variable "destination_bucket" {}
variable "overwrite_objects_already_existing_in_sink" {
  type = bool
}
variable "overwrite_when" {
  type = string
}
variable "schedule_start_date_day_of_month" {
  type = number
}

variable "schedule_start_date_month" {
  type = number
}

variable "schedule_start_date_year" {
  type = number
}

variable "schedule_end_date_day_of_month" {
  type = number
}

variable "schedule_end_date_month" {
  type = number
}

variable "schedule_end_date_year" {
  type = number
}

variable "start_time_of_day_hours" {
  type = number
}

variable "start_time_of_day_minutes" {
  type = number
}

variable "start_time_of_day_seconds" {
  type = number
}

variable "start_time_of_day_nanos" {
  type = number
}

variable "repeat_interval" {
  type = string
}

variable "max_time_elapsed_since_last_modification" {
  type = string
  //13 hours (13*60*60)
  default = "46800s"
}
