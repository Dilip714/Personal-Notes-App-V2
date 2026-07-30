#!/bin/bash
set -euxo pipefail

# Update packages
dnf update -y

# Install Docker and AWS CLI
dnf install -y docker awscli

# Enable Docker
systemctl enable docker
systemctl start docker

# Download Docker image from S3
aws s3 cp \
s3://notes-app-v2-static-assets-582500932246/notes-app-v2.tar \
/tmp/notes-app-v2.tar

# Load Docker image
docker load -i /tmp/notes-app-v2.tar

# Remove archive
rm -f /tmp/notes-app-v2.tar

# Run container
docker run -d \
  --name notes-app \
  --restart unless-stopped \
  -p ${app_port}:${app_port} \
  dilipdev714/notes-app:v2