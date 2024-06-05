#!/bin/bash

# Function to create base network using Docker Compose
main() {
  docker network create \
    --driver=bridge \
    --subnet=172.20.0.0/16 \
    --gateway=172.20.10.1 \
    --ip-range=172.20.10.128/25 \
    devbox_network
}

# Execute main function
main
