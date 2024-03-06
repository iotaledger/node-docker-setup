#!/bin/bash

while true; do
    read -p "Should the existing Hornet installation be updated (existing containers are recreated)? " yn
    case $yn in
        [Yy]* ) docker compose down && docker compose pull && docker compose up -d; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
