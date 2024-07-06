#!/bin/bash

if [ ! -f "/app/config.yaml" ]; then
  echo "Config file config.yaml not found. Renaming config.yaml.example..."
  mv /app/config.yaml.example /app/config.yaml
fi

exec "$@"