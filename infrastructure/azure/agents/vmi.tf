locals {
  agent_images = {
    "pkros1v5nlqoh4g" = "https://saterraformpackerpackern.blob.core.windows.net/images/pkros1v5nlqoh4g.vhd"
  }
}

resource "azurerm_image" "agents" {
  for_each = local.agent_images

  name                = "vmi-${local.project}-${each.key}"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  os_disk {
    os_type  = "Linux"
    os_state = "Generalized"
    blob_uri = each.value
    size_gb  = 86
  }
}