# Integration test: SSH Key resource
# This test follows the documentation examples exactly

# Generate a test SSH key pair for testing
resource "verda_ssh_key" "test" {
  name       = "integration-test-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7vbqajDRfEpwA9VjHSHBQ3H7pZ5TxGkYYxBN3dZwVS5yLK5sxKCxkXc2pZP5cCzRm1LqHRBMDpBYZJqvC9Wvp4sbKe0n9dHIzF7Cr9kpLPQPz6jjqKLrWfU7gZWy9LrCJPYALO1Yf4ZDEz2Z0dLKz5bXGhYa1Z3E8dJPLZvJV5SH5NtYJF7gN7w7F3hV7cLuVHU5Dh0Z5qK1mYj9Z3GhE5nT2YHkM7F5vJV5SH5NtYJF7gN7w7F3hV7cLuVHU5Dh0Z5qK1mYj9Z3GhE5nT integration-test@verda.cloud"
}

# Output SSH key information for verification
output "ssh_key_id" {
  value = verda_ssh_key.test.id
}

output "ssh_key_fingerprint" {
  value = verda_ssh_key.test.fingerprint
}

output "ssh_key_name" {
  value = verda_ssh_key.test.name
}
