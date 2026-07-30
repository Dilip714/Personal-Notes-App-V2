#!/bin/bash
# Runs once on first boot. Installs Docker, starts the daemon, and launches
# the Notes App container automatically — no manual SSH steps needed.
set -euxo pipefail

# 1. Update packages
dnf update -y

# 2. Install Docker
dnf install -y docker

# 3. Start and enable the Docker service (survives reboots)
systemctl start docker
systemctl enable docker

# 4. Pull the app image from Docker Hub
docker pull ${docker_image}

# 5. Run the Notes App container
docker run -d \
  --name notes-app \
  --restart unless-stopped \
  -p ${app_port}:${app_port} \
  ${docker_image}
