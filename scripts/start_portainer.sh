#!/bin/bash

# Function to start Portainer using Docker Compose
main() {
  cd ../compose/ && docker compose -f portainer.yml -p portainer up -d
}

# Execute main function
main
