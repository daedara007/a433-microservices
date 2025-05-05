#!/bin/bash
# Script: build_push_image_karsajobs_ui.sh
# Purpose: Login to GHCR, build the karsajobs-ui frontend image, and push to ghcr.io

set -e

if [[ -z "${GITHUB_USER}" || -z "${CR_PAT}" ]]; then
  echo "ERROR: GITHUB_USER or CR_PAT environment variable not set."
  exit 1
fi

echo "Logging into GitHub Container Registry (ghcr.io)..."
echo "${CR_PAT}" | docker login ghcr.io -u "${GITHUB_USER}" --password-stdin

echo "Building Docker image ghcr.io/${GITHUB_USER}/karsajobs-ui:latest..."
docker build -t ghcr.io/${GITHUB_USER}/karsajobs-ui:latest .

echo "Pushing Docker image to ghcr.io..."
docker push ghcr.io/${GITHUB_USER}/karsajobs-ui:latest

echo "Frontend image pushed successfully."
