# Provider configuration for integration tests
# Credentials are read from environment variables:
#   VERDA_CLIENT_ID
#   VERDA_CLIENT_SECRET

terraform {
  required_providers {
    verda = {
      source  = "verda-cloud/verda"
      version = ">= 1.0.0"
    }
  }
}

provider "verda" {
  # Credentials will be read from environment variables
}
