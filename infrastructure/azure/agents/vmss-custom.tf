module "vmss-custom" {
  source = "github.com/jamesrcounts/terraform-packer.git//infrastructure/azure/modules/vmss"

  disk_encryption_set_id = data.azurerm_key_vault_secret.secrets["disk-encryption-set-id"].value
  project                = "${local.project}-custom"
  resource_group         = data.azurerm_resource_group.main
  source_image_id        = azurerm_image.agents["pkros1v5nlqoh4g"].id
  subnet_id              = data.azurerm_key_vault_secret.secrets["agents-subnet-id"].value
  tags                   = local.tags

  log_analytics_workspace = {
    workspace_id       = data.azurerm_key_vault_secret.secrets["log-analytics-workspace-id"].value
    primary_shared_key = data.azurerm_key_vault_secret.secrets["log-analytics-workspace-key"].value
  }
}
