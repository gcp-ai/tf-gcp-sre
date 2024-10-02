resource "google_cloud_scheduler_job" "job" {
  project          = var.project
  name             = var.name
  description      = var.description
  schedule         = var.schedule
  time_zone        = var.time_zone
  attempt_deadline = var.attempt_deadline
  region           = var.region

  retry_config {
    retry_count = var.retry_count
  }

  http_target {
    http_method = var.http_method
    uri         = var.uri
    body        = base64encode(var.body)
    headers = {
      "Content-Type" : "application/json"
    }
    dynamic "oauth_token" {
      for_each = { for i, v in var.service_account_email : i => v }
      iterator = sa
      content {
        service_account_email = sa.value
      }
    }
  }
}