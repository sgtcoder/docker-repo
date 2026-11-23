#!/usr/bin/env bash
set -e

SCRIPTPATH="$(cd "$(dirname "$0")" && pwd)"
REGISTRY="sgtcoder"
PROJECT_NAME="aptly"

cli_log "INFO" "Building and pushing $REGISTRY/$PROJECT_NAME:latest..."
docker buildx build --push --platform linux/amd64 "$@" -t "$REGISTRY/$PROJECT_NAME:latest" "$SCRIPTPATH"
cli_log "SUCCESS" "Completed successfully" "border"
