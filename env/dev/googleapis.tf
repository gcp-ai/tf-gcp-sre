module "googleapis_storagetransfer" {
  source  = "../../modules/googleapis"
  project = var.project
  service = var.googleapis.storagetransfer
}