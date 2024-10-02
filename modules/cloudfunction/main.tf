resource "google_cloudfunctions2_function" "default" {
  project     = var.project
  name        = var.name
  location    = var.location
  description = var.description
  build_config {
    runtime     = var.runtime
    entry_point = var.entry_point
    source {
      storage_source {
        bucket = var.bucket
        object = var.object
      }
    }
  }
  service_config {
    max_instance_count    = var.max_instance_count
    available_memory      = var.available_memory
    timeout_seconds       = var.timeout
    environment_variables = var.environment_variables
  }

  #event_trigger {
  #    trigger_region = var.location
  #    event_type     = "HTTP"
  #    retry_policy = "RETRY_POLICY_RETRY"
  #}  
  # trigger_http                  = 
  # https_trigger_security_level  = var.https_trigger_security_level
  labels = var.labels
}


data "google_cloud_run_service" "default" {
  project  = var.project
  name     = var.name
  location = var.location

  depends_on = [
    google_cloudfunctions2_function.default
  ]
}


data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }

  depends_on = [
    google_cloudfunctions2_function.default
  ]
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = var.location
  project  = var.project
  service  = data.google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
  depends_on = [
    google_cloudfunctions2_function.default
  ]
}