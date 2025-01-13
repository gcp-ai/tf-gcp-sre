
# module "cloud-function" {
#   source = "../../modules/cloudfunction"
#   #  for_each                    = { for i, v in var.sch : i => v } 
#   project            = local.project_id
#   name               = var.cf_list[0].name
#   location           = var.cf_list[0].location
#   description        = var.cf_list[0].description
#   runtime            = var.cf_list[0].runtime
#   available_memory   = var.cf_list[0].available_memory
#   bucket             = "${local.project_id}_${var.gcs_buckets[0].bucket_name}"
#   object             = var.cf_list[0].object
#   max_instance_count = var.cf_list[0].max_instance_count
#   # trigger_http                  = var.cf_list[0].trigger_http
#   # https_trigger_security_level  = var.cf_list[0].https_trigger_security_level
#   timeout               = var.cf_list[0].timeout
#   entry_point           = var.cf_list[0].entry_point
#   labels                = var.cf_list[0].labels
#   environment_variables = { GCP_PROJECT = local.project_id }

#   depends_on = [
#     module.gcs_object,
#     module.googleapis_cloudfunctions,
#     module.googleapis_artifactregistry,
#     module.gce_internal
#   ]

# }


