resource "google_cloud_run_service" "default" {
  # count    = var.create_count
  name     = var.name
  project  = var.project
  location = var.location

  template {
    spec {
      containers {
        image = var.image


        resources {
          limits = {
            cpu    = var.cpu
            memory = var.memory
          }
        }
      }
    }

    # metadata {
    #   annotations = {
    #     # Limit scale up to prevent any cost blow outs!
    #     "autoscaling.knative.dev/maxScale" = "5"
    #     # Use the VPC Connector
    #     "run.googleapis.com/vpc-access-connector" = var.vpc_name
    #     # all egress from the service should go through the VPC Connector
    #     "run.googleapis.com/vpc-access-egress" = "all"

    #   }
    # }
  }

  traffic {
    percent         = var.percent
    latest_revision = var.latest_revision
  }
}


data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.default.location
  project  = google_cloud_run_service.default.project
  service  = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
}




