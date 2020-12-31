locals {
  client_id       = var.client_id
  client_secret   = var.client_secret
  project         = "terraform-packer"
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id

  tags = {
    project = local.project
  }
}

resource "random_pet" "fido" {}