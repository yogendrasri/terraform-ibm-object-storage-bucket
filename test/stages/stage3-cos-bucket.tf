resource null_resource print_cos_id {
  depends_on = [module.cos.id]
  provisioner "local-exec" {
    command = "echo 'Provisioning bucket into COS instance: ${module.cos.id}'"
  }
}

resource "random_string" "random" {
  length           = 4
  special          = false
}

module "dev_cos_bucket" {
  source = "./module"

  resource_group_name    = module.resource_group.name
  cos_instance_id        = module.cos.id
  name_prefix            = var.name_prefix
  ibmcloud_api_key       = var.ibmcloud_api_key
  label                  = "bucket1-${random_string.random.result}"
  region                 = var.region
  cross_region_location  = var.cross_region_location
  kms_key_crn            = module.hpcs_key.crn
  activity_tracker_crn   = module.activity_tracker.crn
  metrics_monitoring_crn = module.monitoring.crn
  allowed_ip             = ["0.0.0.0/0"]  
  COS-S3-ENDPOINT        = var.COS-S3-ENDPOINT
  ACCESS-KEY             = var.ACCESS-KEY
  SECRET-KEY             = var.SECRET-KEY
}
