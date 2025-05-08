#!/bin/bash
# Script: build_push_image_karsajobs_ui.sh
# Tujuan: Login ke GHCR, build image frontend karsajobs-ui, dan push ke ghcr.io

# Keluar otomatis jika ada perintah yang gagal
set -e

# Check if required environment variables are set
# Memeriksa apakah variabel lingkungan GITHUB_USER dan CR_PAT sudah diset
if [[ -z "${GITHUB_USER}" || -z "${CR_PAT}" ]]; then
  echo "ERROR: GITHUB_USER or CR_PAT environment variable not set."
  exit 1
fi

echo "Logging into GitHub Container Registry (ghcr.io)..."
# Authenticate using GitHub Personal Access Token
# Autentikasi menggunakan GitHub Personal Access Token
echo "${CR_PAT}" | docker login ghcr.io -u "${GITHUB_USER}" --password-stdin

echo "Building Docker image ghcr.io/${GITHUB_USER}/karsajobs-ui:latest..."
# Build image dengan menyertakan environment variable untuk API endpoint
# --build-arg: Mengirim variabel lingkungan ke Dockerfile untuk konfigurasi frontend
docker build -t ghcr.io/${GITHUB_USER}/karsajobs-ui:latest \
  --build-arg VUE_APP_API_BASE_URL=http://karsajobs-service:8000 .

echo "Pushing Docker image to ghcr.io..."
# Mengupload image yang sudah dibuild ke GitHub Container Registry
docker push ghcr.io/${GITHUB_USER}/karsajobs-ui:latest

echo "Frontend image pushed successfully."
# Notifikasi sukses - Image frontend terpush ke registry