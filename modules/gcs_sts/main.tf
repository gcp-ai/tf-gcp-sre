# write main.tf and variable.tf for google_storage_transfer_job having support to run every hour with all configurable parameters with no hardcoding in resource block.
resource "google_storage_transfer_job" "default" {
  project     = var.project
  description = var.description
  transfer_spec {
    gcs_data_source {
      bucket_name = var.source_bucket
    }
    gcs_data_sink {
      bucket_name = var.destination_bucket
    }
    transfer_options {
      overwrite_objects_already_existing_in_sink = var.overwrite_objects_already_existing_in_sink
      overwrite_when                             = var.overwrite_when
    }
    object_conditions {

      max_time_elapsed_since_last_modification = var.max_time_elapsed_since_last_modification

    }
  }
  schedule {
    schedule_start_date {
      day   = var.schedule_start_date_day_of_month
      month = var.schedule_start_date_month
      year  = var.schedule_start_date_year
    }
    schedule_end_date {
      day   = var.schedule_end_date_day_of_month
      month = var.schedule_end_date_month
      year  = var.schedule_end_date_year
    }
    start_time_of_day {
      hours   = var.start_time_of_day_hours
      minutes = var.start_time_of_day_minutes
      seconds = var.start_time_of_day_seconds
      nanos   = var.start_time_of_day_nanos
    }
    repeat_interval = var.repeat_interval
  }
  depends_on = [google_storage_bucket_iam_member.destination, google_storage_bucket_iam_member.source]
}

data "google_storage_transfer_project_service_account" "default" {
  project = var.project
}

resource "google_storage_bucket_iam_member" "destination" {
  bucket = var.destination_bucket
  role   = "roles/storage.admin"
  member = "serviceAccount:${data.google_storage_transfer_project_service_account.default.email}"
}

resource "google_storage_bucket_iam_member" "source" {
  bucket = var.source_bucket
  role   = "roles/storage.admin"
  member = "serviceAccount:${data.google_storage_transfer_project_service_account.default.email}"
}