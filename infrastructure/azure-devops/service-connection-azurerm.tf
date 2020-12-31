resource "azuredevops_serviceendpoint_azurerm" "endpoint_msdn" {
  project_id            = azuredevops_project.project.id
  service_endpoint_name = "Sample AzureRM"
  description           = "Managed by Terraform"
  credentials {
    serviceprincipalid  = local.client_id
    serviceprincipalkey = local.client_secret
  }
  azurerm_spn_tenantid      = local.tenant_id
  azurerm_subscription_id   = local.subscription_id
  azurerm_subscription_name = "Sample Subscription"
}