#!/bin/bash

# Wait for 2 seconds to allow the container to fully start up
sleep 2

# Check if config.yaml already exists
if [ ! -f "/app/config.yaml" ]; then
  echo "Config file config.yaml not found. Renaming config.yaml.example..."
  mv /app/config.yaml.example /app/config.yaml
fi

# Execute the command passed as arguments to entrypoint.sh
exec "$@"
