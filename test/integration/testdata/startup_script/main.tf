# Integration test: Startup Script resource
# This test follows the documentation examples exactly

resource "verda_startup_script" "test" {
  name   = "integration-test-docker-setup"
  script = <<-EOF
    #!/bin/bash
    set -e

    # Update system
    apt-get update
    apt-get upgrade -y

    # Install Docker
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh

    # Add ubuntu user to docker group
    usermod -aG docker ubuntu

    echo "Docker installation completed"
  EOF
}

# Output startup script information for verification
output "startup_script_id" {
  value = verda_startup_script.test.id
}

output "startup_script_name" {
  value = verda_startup_script.test.name
}
