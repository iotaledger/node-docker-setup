#!/bin/bash

#
# node-docker-setup __VERSION__
# https://github.com/iotaledger/node-docker-setup
#

if [ ! -f .env ]; then
  echo "No .env file found. Please see README.md for more details"
fi

if [[ "$OSTYPE" != "darwin"* && "$EUID" -ne 0 ]]; then
  echo "Please run as root or with sudo"
  exit
fi

# Pull latest images
docker compose pull

# Prepare db directory
mkdir -p data
mkdir -p data/grafana
mkdir -p data/prometheus
mkdir -p data/dashboard
mkdir -p data/wasp
if [[ "$OSTYPE" != "darwin"* ]]; then
  chown -R 65532:65532 data
  chown 65532:65532 peering.json
fi
