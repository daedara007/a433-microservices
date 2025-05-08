#!/bin/bash
# Script: build_push_image_karsajobs.sh
# Purpose: Login to GHCR, build the karsajobs backend image, and push to ghcr.io
# Tujuan: Login ke GHCR, membangun image backend karsajobs, dan push ke ghcr.io

# Exit immediately if any command fails
# Keluar segera jika perintah mengembalikan error
set -e

# Ensure GITHUB_USER (GitHub username/organization) and CR_PAT (token) are set
# Memastikan variabel lingkungan GITHUB_USER dan CR_PAT sudah disetel
if [[ -z "${GITHUB_USER}" || -z "${CR_PAT}" ]]; then
  echo "ERROR: GITHUB_USER or CR_PAT environment variable not set."
  exit 1
fi

echo "Logging into GitHub Container Registry (ghcr.io)..."
# Melakukan autentikasi ke GHCR menggunakan Personal Access Token
echo "${CR_PAT}" | docker login ghcr.io -u "${GITHUB_USER}" --password-stdin

echo "Building Docker image ghcr.io/${GITHUB_USER}/karsajobs:latest..."
# Membangun image Docker dari Dockerfile di direktori saat ini
docker build -t ghcr.io/${GITHUB_USER}/karsajobs:latest .

echo "Pushing Docker image to ghcr.io..."
# Mengunggah image yang telah dibangun ke GitHub Container Registry
docker push ghcr.io/${GITHUB_USER}/karsajobs:latest

echo "Backend image pushed successfully."