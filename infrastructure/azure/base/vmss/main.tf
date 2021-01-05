locals {
  admin_username         = "azp"
  disk_encryption_set_id = var.disk_encryption_set_id
  location               = var.resource_group.location
  project                = var.project
  resource_group_name    = var.resource_group.name
  source_image_id        = var.source_image_id
  subnet_id              = var.subnet_id
  tags                   = var.tags
  workspace              = var.log_analytics_workspace
}

