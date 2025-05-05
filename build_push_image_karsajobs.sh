#!/bin/bash
# Script: build_push_image_karsajobs.sh
# Purpose: Login to GHCR, build the karsajobs backend image, and push to ghcr.io

# Exit immediately if any command fails
set -e

# Ensure GITHUB_USER (GitHub username/organization) and CR_PAT (token) are set
if [[ -z "${GITHUB_USER}" || -z "${CR_PAT}" ]]; then
  echo "ERROR: GITHUB_USER or CR_PAT environment variable not set."
  exit 1
fi

echo "Logging into GitHub Container Registry (ghcr.io)..."
# The token (CR_PAT) must have write:packages scope to push images:contentReference[oaicite:8]{index=8}
echo "${CR_PAT}" | docker login ghcr.io -u "${GITHUB_USER}" --password-stdin

# Build the Docker image for the backend; Dockerfile is in current directory
echo "Building Docker image ghcr.io/${GITHUB_USER}/karsajobs:latest..."
docker build -t ghcr.io/${GITHUB_USER}/karsajobs:latest .

# Push the image to GHCR (latest tag)
echo "Pushing Docker image to ghcr.io..."
docker push ghcr.io/${GITHUB_USER}/karsajobs:latest

echo "Backend image pushed successfully."
