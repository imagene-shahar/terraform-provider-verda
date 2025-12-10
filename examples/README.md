# Terraform Provider Verda - Examples

This directory contains example configurations for all resources provided by the Verda Terraform provider.

## Provider Configuration

See [provider.tf](./provider.tf) for provider configuration.

Using environment variables (recommended):

```bash
export VERDA_CLIENT_ID="your-client-id"
export VERDA_CLIENT_SECRET="your-client-secret"
```

```hcl
provider "verda" {}
```

## Resources

Individual resource examples are available in the resources directory.

## Getting Started

1. Install Terraform from [terraform.io](https://www.terraform.io/downloads)

2. Configure credentials:
   ```bash
   export VERDA_CLIENT_ID="your-client-id"
   export VERDA_CLIENT_SECRET="your-client-secret"
   ```

3. Initialize and apply:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```
