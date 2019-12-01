#!/usr/bin/env bash

set -ex

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

BUILD_PUSH=1 python scripts/process_all.py