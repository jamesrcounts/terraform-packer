module "vmss-custom" {
  source = "github.com/jamesrcounts/terraform-packer.git//infrastructure/azure/modules/vmss"

  disk_encryption_set_id = local.disk_encryption_set_id
  project                = "${local.project}-bootstrap"
  resource_group         = local.agents_resource_group
  sku                    = "Standard_D4ds_v4"
  subnet_id              = local.agents_subnet_id
  tags                   = local.tags

  source_image_reference = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18_04-lts-gen2"
    version   = "latest"
  }

  log_analytics_workspace = {
    workspace_id       = local.log_analytics_workspace_id
    primary_shared_key = local.log_analytics_workspace_key
  }
}

locals {
  disk_encryption_set_id      = azurerm_disk_encryption_set.des.id
  agents_resource_group       = azurerm_resource_group.main
  agents_subnet_id            = azurerm_subnet.internal.id
  log_analytics_workspace_id  = azurerm_log_analytics_workspace.insights.workspace_id
  log_analytics_workspace_key = azurerm_log_analytics_workspace.insights.primary_shared_key
}