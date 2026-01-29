# Integration test: Container Registry Credentials resource
# This test follows the documentation examples exactly

# DockerHub credentials (using test values)
resource "verda_container_registry_credentials" "test" {
  name         = "integration-test-dockerhub"
  type         = "dockerhub"
  username     = "testuser"
  access_token = "dckr_pat_test_token_for_integration"
}

# Output credentials information for verification
# Note: This resource uses 'name' as the identifier (no 'id' attribute)
output "credentials_name" {
  value = verda_container_registry_credentials.test.name
}

output "credentials_type" {
  value = verda_container_registry_credentials.test.type
}

output "credentials_created_at" {
  value = verda_container_registry_credentials.test.created_at
}
