resource "azurerm_public_ip_prefix" "pib" {
  location            = local.location
  name                = "pib-${local.project}"
  prefix_length       = 31
  resource_group_name = local.resource_group_name
  tags                = local.tags
}