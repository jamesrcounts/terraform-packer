resource "azuredevops_variable_group" "variablegroup" {
  project_id   = azuredevops_project.project.id
  name         = "Test Variable Group"
  description  = "Test Variable Group Description"
  allow_access = true

  variable {
    name  = "key"
    value = "value"
  }

  variable {
    name         = "Account Password"
    secret_value = "p@ssword123"
    is_secret    = true
  }
}