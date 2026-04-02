# terraform-packer

Azure infrastructure and Packer image templates for self-hosted Azure Pipelines build agents.

## What This Does

- Provisions Azure infrastructure (resource groups, VNet, Key Vault, Shared Image Gallery, VMSS) via Terraform
- Builds custom Ubuntu VM images using Packer and stores them in Azure Shared Image Gallery
- Configures an Azure DevOps project with pipelines, service connections, and variable groups via Terraform

## Structure

```
infrastructure/
  azure/
    base/         # Core Azure resources (VNet, Key Vault, SIG, VMSS bootstrap)
    agents/       # Build agent VMSS consuming images from SIG
  azure-devops/   # Azure DevOps project and pipeline configuration
  images/         # Packer templates and Azure Pipelines YAML
```

## Usage

Apply base infrastructure:

```bash
make base
```

Apply build agent infrastructure:

```bash
make agents
```

Validate Packer templates:

```bash
cd infrastructure/images && make validate
```

See `CLAUDE.md` for full command reference and architecture details.

## Prerequisites

- Terraform Cloud account (`jamesrcounts` org) with `TFE_TOKEN` set
- Azure service principal with credentials set as environment variables (`ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_SUBSCRIPTION_ID`, `ARM_TENANT_ID`)
- Azure CLI, Terraform 0.14+, and Packer installed (or use the provided dev container)

## Dev Container

Open in VS Code with the Remote - Containers extension for a pre-configured environment with Terraform, tflint, Azure CLI, Docker, and PowerShell.
