#!/bin/bash
set -euxo pipefail

# Update packages
dnf update -y

# Install Docker and AWS CLI
dnf install -y docker awscli

# Enable and start Docker
systemctl enable docker
systemctl start docker

# Download the pre-built Docker image archive from S3.
# The private instance reaches S3 through the Gateway VPC Endpoint.
aws s3 cp \
  s3://${bucket_name}/notes-app-v2.tar \
  /tmp/notes-app-v2.tar

# Load Docker image
docker load -i /tmp/notes-app-v2.tar

# Remove temporary archive
rm -f /tmp/notes-app-v2.tar

# Run the application
docker run -d \
  --name notes-app \
  --restart unless-stopped \
  -p ${app_port}:${app_port} \
  dilipdev714/notes-app:v2