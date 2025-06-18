# OIDC CI/CD Demo for PlatformCon 2025

This repository shows how to use OpenID Connect (OIDC) to authenticate GitHub Actions workflows with GCP and Vault.

## Structure

- **gcp/** — Terraform code for setting up OIDC with Google Cloud Platform, including Workload Identity Pools and permissions for Artifact Registry.
- **vault/** — Terraform configuration for Vault's JWT auth backend to allow GitHub Actions to access secrets.
- **.github/workflows/** — Example GitHub Actions workflows on how to authenticate to GCP and retrieve secrets from Vault.

# Article

This demo is part of the [Secure Deployments on Github using OIDC (OpenID Connect)](#)
