#!/bin/bash
set -e

VERSION=$1
IMAGE_NAME=ghcr.io/${GITHUB_REPOSITORY,,}

echo "Building Docker image ${IMAGE_NAME}:${VERSION}"
docker build -t ${IMAGE_NAME}:${VERSION} .

echo "Tagging as latest"
docker tag ${IMAGE_NAME}:${VERSION} ${IMAGE_NAME}:latest

echo "Pushing ${VERSION} and latest to GHCR"
docker push ${IMAGE_NAME}:${VERSION}
docker push ${IMAGE_NAME}:latest