locals {
  agent_images = {
    "pkros1v5nlqoh4g" = "https://saterraformpackerpackern.blob.core.windows.net/images/pkros1v5nlqoh4g.vhd"
    "pkrosfccg6m89e7" = "https://saterraformpackerpackern.blob.core.windows.net/images/pkrosfccg6m89e7.vhd"
    "pkrosv7zehc5jio" = "https://saterraformpackerpackern.blob.core.windows.net/images/pkrosv7zehc5jio.vhd"
    "pkrdpm1d19vntby" = "https://saterraformpackerpackern.blob.core.windows.net/images/pkrdpm1d19vntby.vhd"
  }
}

resource "azurerm_image" "agents" {
  for_each = local.agent_images

  name                = "vmi-${local.project}-${each.key}"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  tags                = local.tags

  os_disk {
    os_type  = "Linux"
    os_state = "Generalized"
    blob_uri = each.value
    size_gb  = 100 // TODO support by sku?
  }
}