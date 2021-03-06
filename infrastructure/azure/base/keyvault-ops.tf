## Todo JSON encode?
locals {
  ops_secrets = {
    "agents-subnet-id"            = azurerm_subnet.internal.id
    "disk-encryption-set-id"      = azurerm_disk_encryption_set.des.id
    "log-analytics-workspace-id"  = azurerm_log_analytics_workspace.insights.workspace_id
    "log-analytics-workspace-key" = azurerm_log_analytics_workspace.insights.primary_shared_key
  }
}

resource "azurerm_key_vault" "ops" {
  enable_rbac_authorization       = true
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = false
  location                        = azurerm_resource_group.main.location
  name                            = "kv-${local.project}-ops"
  resource_group_name             = azurerm_resource_group.main.name
  sku_name                        = "standard"
  soft_delete_retention_days      = 30
  purge_protection_enabled        = true
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  tags                            = local.tags

  contact {
    email = "joe@olive-steel.com"
    name  = "Joe Secrets"
    phone = "(555) 555-5555"
  }
}


resource "azurerm_key_vault_secret" "secrets" {
  for_each = local.ops_secrets

  name         = each.key
  value        = each.value
  key_vault_id = azurerm_key_vault.ops.id
  tags         = local.tags
}