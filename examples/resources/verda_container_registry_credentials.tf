# DockerHub credentials
resource "verda_container_registry_credentials" "dockerhub" {
  name         = "my-dockerhub-credentials"
  type         = "dockerhub"
  username     = "myusername"
  access_token = "dckr_pat_xxxxxxxxxxxxx"
}

# GitHub Container Registry (GHCR) credentials
resource "verda_container_registry_credentials" "ghcr" {
  name         = "github-registry"
  type         = "ghcr"
  username     = "myghusername"
  access_token = "ghp_xxxxxxxxxxxxx"
}

# Google Container Registry (GCR) credentials
resource "verda_container_registry_credentials" "gcr" {
  name                = "google-registry"
  type                = "gcr"
  service_account_key = file("${path.module}/gcr-service-account.json")
}

# AWS Elastic Container Registry (ECR) credentials
resource "verda_container_registry_credentials" "ecr" {
  name              = "aws-ecr"
  type              = "ecr"
  access_key_id     = "AKIAXXXXXXXXXXXXXXXX"
  secret_access_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  region            = "us-east-1"
  ecr_repo          = "123456789012.dkr.ecr.us-east-1.amazonaws.com"
}

# Scaleway Container Registry credentials
resource "verda_container_registry_credentials" "scaleway" {
  name            = "scaleway-registry"
  type            = "scaleway"
  access_token    = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  scaleway_domain = "rg.fr-par.scw.cloud"
  scaleway_uuid   = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}

# Using Docker config.json
resource "verda_container_registry_credentials" "docker_config" {
  name               = "custom-registry"
  type               = "dockerhub"
  docker_config_json = file("${path.module}/.docker/config.json")
}
