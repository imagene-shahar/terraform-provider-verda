#!/usr/bin/env bash
#
# Cleanup script for integration test resources
#
# This is a convenience wrapper that calls the main integration test script
# with the --cleanup-only flag.
#
# Usage:
#   ./scripts/cleanup-test-resources.sh
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "${SCRIPT_DIR}/run-integration-tests.sh" --cleanup-only "$@"
