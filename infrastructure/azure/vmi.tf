resource "azurerm_image" "agent" {
  name                = "vmi-${local.project}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  os_disk {
    os_type  = "Linux"
    os_state = "Generalized"
    blob_uri = "https://saterraformpackerpackerp.blob.core.windows.net/images/pkrosgbh4lolumx.vhd"
    size_gb  = 86
  }
}