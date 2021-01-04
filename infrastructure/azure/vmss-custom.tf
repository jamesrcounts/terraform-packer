module "vmss-custom" {
  source = "./vmss"

  disk_encryption_set_id  = azurerm_disk_encryption_set.des.id
  log_analytics_workspace = azurerm_log_analytics_workspace.insights
  project                 = "${local.project}-custom"
  resource_group          = azurerm_resource_group.main
  source_image_id         = azurerm_image.agent.id
  subnet_id               = azurerm_subnet.internal.id
  tags                    = local.tags
}