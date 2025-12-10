# Basic serverless job deployment example using public registry
resource "verda_serverless_job" "example" {
  name = "my-batch-job"

  compute = {
    name = "H100"
    size = 1
  }

  scaling = {
    max_replica_count               = 5
    queue_message_ttl_seconds       = 7200
    deadline_seconds                = 3600
  }

  containers = [
    {
      image        = "python:3.11-slim"
      exposed_port = 8080
    }
  ]
}

# Serverless job with private registry and environment variables
resource "verda_container_registry_credentials" "job_registry" {
  name         = "job-registry-creds"
  type         = "dockerhub"
  username     = "myuser"
  access_token = var.dockerhub_token
}

resource "verda_serverless_job" "data_processing" {
  name = "data-processing-job"

  compute = {
    name = "A100"
    size = 2
  }

  scaling = {
    max_replica_count               = 10
    queue_message_ttl_seconds       = 14400
    deadline_seconds                = 7200
  }

  container_registry_settings = {
    is_private  = "true"
    credentials = verda_container_registry_credentials.job_registry.name
  }

  containers = [
    {
      image        = "myregistry.io/data-processor:v2.0"
      exposed_port = 8080

      env = [
        {
          type                         = "plain"
          name                         = "BATCH_SIZE"
          value_or_reference_to_secret = "100"
        },
        {
          type                         = "secret"
          name                         = "API_KEY"
          value_or_reference_to_secret = "api-key-secret"
        },
        {
          type                         = "plain"
          name                         = "LOG_LEVEL"
          value_or_reference_to_secret = "INFO"
        }
      ]
    }
  ]
}

# Serverless job with entrypoint override and volume mounts
resource "verda_serverless_job" "ml_inference" {
  name = "ml-inference-job"

  compute = {
    name = "H100"
    size = 4
  }

  scaling = {
    max_replica_count               = 20
    queue_message_ttl_seconds       = 3600
    deadline_seconds                = 1800
  }

  containers = [
    {
      image        = "ml-model:latest"
      exposed_port = 8000

      # Override the container entrypoint to run a custom script
      entrypoint_overrides = {
        enabled    = true
        entrypoint = ["/bin/bash", "-c"]
        cmd        = ["python inference.py --model-path /models --batch-size 32"]
      }

      # Mount volumes for model storage and temporary data
      volume_mounts = [
        # Scratch volume for temporary processing
        {
          type       = "scratch"
          mount_path = "/tmp/processing"
          size_in_mb = 10240
        },
        # Secret volume for model files
        {
          type        = "secret"
          mount_path  = "/models"
          secret_name = "ml-model-weights"
        }
      ]

      env = [
        {
          type                         = "plain"
          name                         = "MODEL_NAME"
          value_or_reference_to_secret = "resnet50"
        },
        {
          type                         = "plain"
          name                         = "DEVICE"
          value_or_reference_to_secret = "cuda"
        }
      ]
    }
  ]
}

# Serverless job with shared volume mount
resource "verda_volume" "job_data" {
  name     = "job-data-volume"
  size     = 500
  type     = "NVMe_Shared"
  location = "FIN-01"
}

resource "verda_serverless_job" "batch_processor" {
  name = "batch-processor"

  compute = {
    name = "A100"
    size = 1
  }

  scaling = {
    max_replica_count               = 8
    queue_message_ttl_seconds       = 7200
    deadline_seconds                = 3600
  }

  containers = [
    {
      image        = "batch-processor:v1.5"
      exposed_port = 8080

      volume_mounts = [
        # Shared volume for input/output data
        {
          type       = "shared"
          mount_path = "/data"
          volume_id  = verda_volume.job_data.id
        }
      ]
    }
  ]
}
