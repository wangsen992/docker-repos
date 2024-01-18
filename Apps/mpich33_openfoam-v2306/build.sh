#!/bin/bash

# rebuild the dependencies first
# This is a three stage build process. The first is for interactive setup
DOCKER_ACCOUNT=wangsen992
DOCKER_DIR=${0%/*}/../..
BASE_DEV_IMAGE=ubuntu22_dev
DEST_DEV_IMAGE=mpich33
TARGET_IMAGE=mpich33_openfoam-v2306

echo $DOCKER_DIR

echo Building $DOCKER_ACCOUNT/$BASE_DEV_IMAGE:build
docker build -t $DOCKER_ACCOUNT/$BASE_DEV_IMAGE:build \
			$DOCKER_DIR/OS/$BASE_DEV_IMAGE -f $DOCKER_DIR/OS/$BASE_DEV_IMAGE/Dockerfile

echo Building $DOCKER_ACCOUNT/$DEST_DEV_IMAGE:build
docker build -t $DOCKER_ACCOUNT/$DEST_DEV_IMAGE:build \
			$DOCKER_DIR/CompEnvs/$DEST_DEV_IMAGE -f $DOCKER_DIR/CompEnvs/$DEST_DEV_IMAGE/Dockerfile

echo Building $DOCKER_ACCOUNT/$TARGET_IMAGE:latest
echo Removing previously built image and cache
docker image rm $DOCKER_ACCOUNT/$TARGET_IMAGE:latest
docker builder prune -f
docker build \
			--no-cache \
			-t $DOCKER_ACCOUNT/$TARGET_IMAGE:latest \
			$DOCKER_DIR/Apps/$TARGET_IMAGE -f $DOCKER_DIR/Apps/$TARGET_IMAGE/Dockerfile
