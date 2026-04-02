# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repository manages Azure infrastructure for self-hosted Azure Pipelines build agents. It uses:
- **Terraform** to provision Azure resources (resource groups, VNets, Key Vaults, SIG, VMSS) and Azure DevOps project configuration
- **Packer** to build custom Ubuntu VM images stored in Azure Shared Image Gallery (SIG)
- **Azure Pipelines** to trigger image builds on the custom agents themselves

## Commands

### Root-Level Make Targets

```bash
make          # Applies base infrastructure (default)
make base     # cd infrastructure/azure/base && make apply
make agents   # cd infrastructure/azure/agents && make apply
```

### Terraform (run from within each module directory)

```bash
make apply    # terraform fmt + init -get=false + validate + apply
make init     # terraform init --upgrade
make validate # terraform validate
make fmt      # terraform fmt -recursive
make clean    # terraform destroy -auto-approve
make connect  # terraform init -get=false (refresh modules without upgrading)
```

### Packer Validation

```bash
cd infrastructure/images && make validate
# Runs: packer validate -syntax-only linux/ubuntu2004.json
```

### Azure DevOps Validation Note

When running `make validate` in `infrastructure/azure-devops/`, the Makefile injects a fake `AZDO_GITHUB_SERVICE_CONNECTION_PAT` so validation can run without real credentials.

## Architecture

### Two-Stage Image Build Process

1. **Bootstrap stage** (`ubuntu1804.bootstrapper.json` / `ubuntu2004.bootstrapper.json`): Builds a base image with minimal tooling; stored as the `bootstrap` image in SIG.
2. **Custom stage** (`ubuntu1804.custom.json` / `ubuntu2004.custom.json`): Builds atop the bootstrap image to produce the full build agent environment; stored as the `custom` image in SIG.

The CI pipeline (`infrastructure/images/azure-pipelines.yml`) drives this via `build-image.ps1` and `cleanup.ps1`. Image versions use the Azure Pipelines build number (`0.1.$(Rev:r)`). The pipeline requires variables from the `terraform-packer` variable group: `AZURE_RESOURCE_GROUP`, `AZURE_LOCATION`, `SIG_NAME`, `TFE_TOKEN`, `GITHUB_TOKEN`.

### Terraform Module Layout

```
infrastructure/
  azure/
    base/      # Core Azure resources: resource groups, VNet, Key Vault, SIG, SSH, log analytics, VMSS bootstrap
    agents/    # Build agent VMSS (consumes bootstrap image from SIG via data source)
    modules/   # Reusable modules (vmss module sourced from GitHub)
  azure-devops/ # Azure DevOps project, service connection, variable group
  images/       # Packer templates and CI pipeline YAMLs
```

### Key Resources and Naming Conventions

- Resource groups: `rg-terraform-packer` (main), `rg-terraform-packer-images` (image storage)
- Shared Image Gallery: `sig.terraform.packer` (dots instead of dashes — Azure SIG naming requirement)
- SIG images: `bootstrap` and `custom`
- VMSS SKU: `Standard_D4ds_v4`
- Location: `centralus`

### Terraform Backend

All modules use **Terraform Cloud** remote backend, org `jamesrcounts`, workspace `terraform-packer`. Authentication uses `TFE_TOKEN`.

### Secrets Management

Azure Key Vault stores runtime secrets (disk-encryption-set-id, agents-subnet-id, log analytics workspace details). The `agents` module reads these via `azurerm_key_vault_secret` data sources. Packer templates read Azure credentials from environment variables (`ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_SUBSCRIPTION_ID`, `ARM_TENANT_ID`).

### Dev Container

The `.devcontainer/` configuration provides a ready-to-use environment with Terraform 0.14.4, tflint 0.18.0, Azure CLI, Docker, and PowerShell installed. VS Code extensions for Terraform, Azure, and Docker are pre-configured.

### Code Style

- `.editorconfig` enforces 2-space indentation and LF line endings for `.tf` files.
- Run `terraform fmt -recursive` before committing Terraform changes.
