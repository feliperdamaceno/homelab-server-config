#!/bin/bash

# What it does? Install Docker and Docker Compose on Ubuntu Server.

# Function to add Docker's official GPG key
include_docker_GPG_keys() {
  sudo apt-get update
  sudo apt-get install ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
}

# Function to add Docker repository to Apt sources
include_docker_repository_to_apt_sources() {
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
  sudo apt-get update
}

# Function to install Docker
install_docker_and_docker_compose() {
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

validate_docker_instalation() {
  if ! command -v docker &>/dev/null || ! systemctl status docker | grep -q "Active: active (running)"; then
    echo "Docker installation failed or Docker service is not running. Please check."
    exit 1
  fi
}

# Function to add current user to Docker group
add_user_to_docker_group() {
  sudo usermod -aG docker $USER
  newgrp docker
}

# Function to set Docker to start on boot
set_docker_start_on_boot() {
  sudo systemctl enable docker.service containerd.service
}

# Main function
main() {
  include_docker_GPG_keys
  include_docker_repository_to_apt_sources
  install_docker_and_docker_compose
  validate_docker_instalation
  add_user_to_docker_group
  set_docker_start_on_boot
}

# Execute main function
main
