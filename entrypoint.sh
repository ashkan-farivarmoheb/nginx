#!/bin/bash
set -e

# Choose configuration based on the environment
if [ "$ENVIRONMENT" == "prod" ]; then
  CONFIG_FILE="/etc/nginx/prod.conf"
else
  CONFIG_FILE="/etc/nginx/nonprod.conf"
fi

echo "Using NGINX config: $CONFIG_FILE"

# Start NGINX with the chosen configuration
nginx -g "daemon off;" -c "$CONFIG_FILE"
