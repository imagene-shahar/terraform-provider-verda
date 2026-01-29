# Configurable variables for integration tests
# Override via environment variables using TF_VAR_* pattern
# Example: TF_VAR_instance_type=1RTXPRO6000.30V

variable "instance_type" {
  description = "Instance type for testing"
  type        = string
  default     = "1B200.30V" # Default from docs
}

variable "instance_image" {
  description = "Instance image for testing"
  type        = string
  default     = "ubuntu-24.04-cuda-12.8-open-docker"
}

variable "instance_location" {
  description = "Instance location for testing"
  type        = string
  default     = "FIN-03"
}
