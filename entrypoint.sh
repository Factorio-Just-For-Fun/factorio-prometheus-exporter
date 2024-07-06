#!/bin/bash

# Ensure /app directory exists
mkdir -p /app

# Function to check if config.yaml exists
check_config() {
  if [ -f "/app/config.yaml" ]; then
    return 0
  else
    return 1
  fi
}

# Function to perform the rename operation
rename_config() {
  echo "Renaming config.yaml.example to config.yaml..."
  mv /app/config.yaml.example /app/config.yaml
}

# Wait for 5 seconds to allow the container to fully start up
sleep 5

# Check if config.yaml already exists
if ! check_config; then
  echo "Config file config.yaml not found. Attempting to rename config.yaml.example..."

  # Attempt to rename up to 3 times with increasing delay (1, 2, 3 seconds)
  for i in {1..3}; do
    rename_config && break
    sleep $i
  done

  # Check if rename was successful
  if ! check_config; then
    echo "Failed to rename config.yaml.example to config.yaml"
    exit 1
  fi
fi

# Execute the command passed as arguments to entrypoint.sh
exec "$@"
