locals {
  agent_images = {
    "pkros1v5nlqoh4g" = {
      blob_uri = "https://saterraformpackerpackern.blob.core.windows.net/images/pkros1v5nlqoh4g.vhd"
      size_gb  = 86
    }
    "pkrosfccg6m89e7" = {
      blob_uri = "https://saterraformpackerpackern.blob.core.windows.net/images/pkrosfccg6m89e7.vhd"
      size_gb  = 86
    }
    "pkrosv7zehc5jio" = {
      blob_uri = "https://saterraformpackerpackern.blob.core.windows.net/images/pkrosv7zehc5jio.vhd"
      size_gb  = 86
    }
    "pkrosm1d19vntby" = {
      blob_uri = "https://saterraformpackerpackern.blob.core.windows.net/images/pkrosm1d19vntby.vhd",
      size_gb  = 100
    }
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
    blob_uri = each.value.blob_uri
    size_gb  = each.value.size_gb
  }
}