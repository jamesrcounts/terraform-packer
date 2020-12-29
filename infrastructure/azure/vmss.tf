resource "azurerm_linux_virtual_machine_scale_set" "agents" {
  admin_username              = "adminuser"
  instances                   = 2
  location                    = azurerm_resource_group.main.location
  name                        = "vmss-${local.project}"
  overprovision               = false
  platform_fault_domain_count = 1
  resource_group_name         = azurerm_resource_group.main.name
  single_placement_group      = false
  sku                         = "Standard_DS2_v2"
  tags                        = local.tags
  upgrade_mode                = "Manual"

  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.key.public_key_openssh
  }


  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadOnly"
    diff_disk_settings {
      option = "Local"
    }

  }

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.internal.id
      public_ip_address {
        name                = "public"
        public_ip_prefix_id = azurerm_public_ip_prefix.pib.id
      }
    }
  }
}

resource "azurerm_public_ip_prefix" "pib" {
  location            = azurerm_resource_group.main.location
  name                = "pib-${local.project}"
  prefix_length       = 31
  resource_group_name = azurerm_resource_group.main.name
  tags                = local.tags
}