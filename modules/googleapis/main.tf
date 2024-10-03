resource "google_project_service" "googleapis" {
  project                    = var.project
  service                    = var.service
  disable_dependent_services = true
  disable_on_destroy         = false

}


