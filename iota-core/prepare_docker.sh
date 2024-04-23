#!/bin/bash

#
# node-docker-setup __VERSION__
# https://github.com/iotaledger/node-docker-setup
#

SNAPSHOT_FILE_PATH="data/snapshots/snapshot.bin"
SNAPSHOT_URL=""

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
mkdir -p data/snapshots
mkdir -p data/dashboard
if [[ "$OSTYPE" != "darwin"* ]]; then
  chown -R 65532:65532 data
  chown 65532:65532 peering.json
fi

# Check if the snapshot file already exists and delete it if it does
if [ -f "$SNAPSHOT_FILE_PATH" ]; then
    echo "Delete existing snapshot at $SNAPSHOT_FILE_PATH..."
    rm $SNAPSHOT_FILE_PATH
fi

# Download the snapshot file
echo "Downloading latest snapshot from $SNAPSHOT_URL..."
curl -o $SNAPSHOT_FILE_PATH $SNAPSHOT_URL

# Check if the snapshot download was successful
if [ $? -eq 0 ]; then
    echo "Snapshot download completed successfully!"
else
    echo "Error downloading the snapshot file."
fi