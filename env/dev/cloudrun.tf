# module "cloudrun" {
#   source = "../../modules/cloudrun"

#   project         = local.project_id  
#   name            = var.cloudrunarr[0].crun_name
#   location        = var.meta_region
#   image           = var.cloudrunarr[0].crun_image
#   cpu             = var.cloudrunarr[0].crun_cpu
#   memory          = var.cloudrunarr[0].crun_memory
#   percent         = var.cloudrunarr[0].crun_percent
#   latest_revision = var.cloudrunarr[0].crun_latest_revision
# }






