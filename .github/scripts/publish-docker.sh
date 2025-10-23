#!/bin/bash
set -e

ARTIFACT_NAME=$1
VERSION=$2
IMAGE_NAME=ghcr.io/${GITHUB_REPOSITORY,,}/${ARTIFACT_NAME}
PLATFORMS=${PLATFORMS:-"linux/amd64,linux/arm64"}

echo "Setting up Docker buildx for multi-platform builds"
docker buildx create --use --name multiarch-builder --driver docker-container --bootstrap 2>/dev/null || docker buildx use multiarch-builder

echo "Building and pushing multi-platform Docker image ${IMAGE_NAME} for platforms: ${PLATFORMS}"
docker buildx build \
  --platform ${PLATFORMS} \
  --tag ${IMAGE_NAME}:${VERSION} \
  --tag ${IMAGE_NAME}:latest \
  --push \
  .