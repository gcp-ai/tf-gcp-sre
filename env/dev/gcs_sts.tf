module "gcs_sts" {
  source                                     = "../../modules/gcs_sts"
  for_each                                   = { for i, v in var.gcs_sts : i => v }
  project                                    = var.project_id
  description                                = each.value.description
  source_bucket                              = "tf-jobload"
  destination_bucket                         = "tf-jobload-backup"
  overwrite_objects_already_existing_in_sink = each.value.overwrite_objects_already_existing_in_sink
  overwrite_when                             = each.value.overwrite_when
  schedule_start_date_day_of_month           = each.value.schedule_start_date_day_of_month
  schedule_start_date_month                  = each.value.schedule_start_date_month
  schedule_start_date_year                   = each.value.schedule_start_date_year
  schedule_end_date_day_of_month             = each.value.schedule_end_date_day_of_month
  schedule_end_date_month                    = each.value.schedule_end_date_month
  schedule_end_date_year                     = each.value.schedule_end_date_year
  start_time_of_day_hours                    = each.value.start_time_of_day_hours
  start_time_of_day_minutes                  = each.value.start_time_of_day_minutes
  start_time_of_day_seconds                  = each.value.start_time_of_day_seconds
  start_time_of_day_nanos                    = each.value.start_time_of_day_nanos
  repeat_interval                            = each.value.repeat_interval

  depends_on = [
  ]
}