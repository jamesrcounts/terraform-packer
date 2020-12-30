resource "azuredevops_serviceendpoint_github" "serviceendpoint" {
  project_id            = azuredevops_project.project.id
  service_endpoint_name = "GithHub Personal Access Token"

  auth_personal {}
}