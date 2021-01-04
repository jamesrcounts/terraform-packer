locals {
  agent_images = {
    "pkrosgbh4lolumx" = "https://saterraformpackerpackerp.blob.core.windows.net/images/pkrosgbh4lolumx.vhd"
    "pkroshlqdn5kepx" = "https://saterraformpackerpackerp.blob.core.windows.net/images/pkroshlqdn5kepx.vhd"
  }
}

resource "azurerm_image" "agents" {
  for_each = local.agent_images

  name                = "vmi-${local.project}-${each.key}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  os_disk {
    os_type  = "Linux"
    os_state = "Generalized"
    blob_uri = each.value
    size_gb  = 86
  }
}