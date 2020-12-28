locals {
  project = "terraform-packer"

  tags = {
    Environment = local.project
  }
}

resource "random_pet" "fido" {}