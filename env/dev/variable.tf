# Meta variables
#################################################

variable "meta_env" {}
variable "meta_project_prefix" {}
variable "meta_region" {}
variable "meta_zone" {}
variable "meta_sa_name" {}
variable "project_id" {}
variable "project" {}

variable "GOOGLE_CREDENTIALS" { default = null }

# Googleapis variables
#################################################
variable "googleapis" { type = map(any) }


# Service Account
#################################################
variable "serviceaccount" {}


# VPC
#################################################
variable "vpc" {}


variable "vpc_peering" {}

# Firewall variables
#################################################
variable "fw_rules" {}

# Workbench
#################################################
variable "workbench_instance_name" {}
variable "workbench_machine_type" {}

# Endpoint
#################################################
variable "endpoint_name" {}


# EndPoint binding 
#################################################
variable "endpoint_binding_role" {}
variable "endpoint_binding_members" {}

# EndPoint Member 
#################################################
variable "endpoint_member_role" {}
variable "endpoint_member" {}

# EndPoint Policy 
#################################################
variable "endpoint_policy_role" {}
variable "endpoint_policy_members" {}

# Metadata Store
#################################################
variable "metadata_name" {}


# VAI Tensorboard
#################################################


# Workbench Policy 
#################################################
variable "workbench_policy_role" {}
variable "workbench_policy_members" {}

# Workbench Member  
#################################################
variable "workbench_member_role" {}
variable "workbench_member" {}


# Workbench binding 
#################################################
variable "workbench_binding_role" {}
variable "workbench_binding_members" {}



# Feature Group
#################################################
variable "feature_group" {}


# Feature Store
#################################################
variable "feature_store" {}


# bigquery #
#################################################
variable "bigquery_dataset" {}


# GCS
#################################################
variable "gcs_buckets" {

}

# GCS Public
################################################# 
variable "bucket_role" {}
variable "bucket_entity" {}


variable "cloudsql_instances" {}
variable "cloudsql_databases" {}
variable "cloudsql_users" {}


# GCS STS
##################################################
variable "gcs_sts" {}
