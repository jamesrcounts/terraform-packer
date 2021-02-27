resource "azuredevops_variable_group" "variablegroup" {
  project_id   = azuredevops_project.project.id
  name         = local.project
  description  = "Variables for ${local.project} packer pipelines"
  allow_access = false

  variable {
    name  = "AZURE_RESOURCE_GROUP"
    value = "rg-${local.project}-images"
  }

  variable {
    name  = "AZURE_LOCATION"
    value = "centralus"
  }

  variable {
    name  = "BUILD_AGENT_VNET_NAME"
    value = "network-terraform-packer"
  }

  variable {
    name  = "BUILD_AGENT_VNET_RESOURCE_GROUP"
    value = "rg-${local.project}"
  }

  variable {
    name  = "BUILD_AGENT_SUBNET_NAME"
    value = "internal"
  }

  variable {
    name  = "PRIVATE_VIRTUAL_NETWORK_WITH_PUBLIC_IP"
    value = true
  }

  variable {
    name  = "SIG_NAME"
    value = "sig.terraform.packer"
  }

  variable {
    is_secret = true
    name      = "GITHUB_TOKEN"
    value     = local.github_pat
  }
}