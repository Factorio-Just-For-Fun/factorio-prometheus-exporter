#!/bin/bash

# Function to check if config.yaml exists
check_config() {
  if [ -f "/app/config.yaml" ]; then
    return 0
  else
    return 1
  fi
}

# Wait for 5 seconds to allow the container to fully start up
sleep 5

# Check if config.yaml already exists
if ! check_config; then
  echo "Config file config.yaml not found. Renaming config.yaml.example..."
  mv /app/config.yaml.example /app/config.yaml

  # Check if rename was successful
  if ! check_config; then
    echo "Failed to rename config.yaml.example to config.yaml"
    exit 1
  fi
fi

# Execute the command passed as arguments to entrypoint.sh
exec "$@"
