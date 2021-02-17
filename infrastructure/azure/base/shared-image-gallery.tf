resource "azurerm_shared_image_gallery" "images" {
  description         = "Custom VM Images."
  location            = azurerm_resource_group.main.location
  name                = replace("sig-${local.project}", "-", ".")
  resource_group_name = azurerm_resource_group.main.name
  tags                = local.tags
}