# module "scheduler-user-database" {
#   source           = "../../modules/scheduler"
#   for_each         = { for i, v in var.sch_user_db : i => v }
#   project          = local.project_id
#   region           = var.meta_region
#   name             = each.value.name
#   description      = each.value.description
#   schedule         = each.value.schedule
#   time_zone        = each.value.time_zone
#   attempt_deadline = each.value.attempt_deadline
#   retry_count      = each.value.retry_count
#   http_method      = each.value.http_method
#   uri              = local.cloud_func_url_userdb
#   body             = local.scheduler_body
 
#   service_account_email = []
#   depends_on = [
#     module.cloud-function
#   ]
# }







# data "google_cloud_run_service" "default" {
#   project  = local.project_id
#   name     = var.cf_list[0].name
#   location = var.cf_list[0].location
#   depends_on = [
#     module.cloud-function
#   ]
# }
# module "scheduler-ssd" {
#   source                = "../../modules/scheduler"
#   for_each              = { for i, v in var.sch_disk : i => v }
#   project               = local.project_id
#   region                = var.meta_region
#   name                  = each.value.name
#   description           = each.value.description
#   schedule              = each.value.schedule
#   time_zone             = each.value.time_zone
#   attempt_deadline      = each.value.attempt_deadline
#   retry_count           = each.value.retry_count
#   http_method           = each.value.http_method
#   uri                   = local.cloud_func_url_disk
#   body                  = each.value.body
#   service_account_email = []
#   #service_account_email = data.google_compute_default_service_account.default.email
#   depends_on = [
#     module.cloud-function
#   ]
# }