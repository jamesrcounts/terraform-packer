locals {
  project = "terraform-packer"

  tags = {
    project = local.project
  }
}

resource "random_pet" "fido" {}