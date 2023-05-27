#!/bin/bash

# If no argument provided, the script will exit with status code 1
test $# = 0 && (echo "Provide a GitHub repo & Docker hub registry address"; exit 1)

# Check if env variables are set, then login to Docker Hub
env | grep -v "DOCKER_USER\|DOCKER_PWD" && docker login -u $DOCKER_USER -p $DOCKER_PWD

# Assign the first & second arguments to `docker run ...` command
gh_repo=$1
dockerhub_repo=$2

# Check if both arguments are strings
if [ -z ${gh_repo} ] || [ -z ${dockerhub_repo} ]; then
  echo "Both arguments must be strings" && exit 1
fi

docker_tag="${gh_repo}:latest"

# Build Docker image from GitHub repo and tag it with the given tag
docker build -t ${docker_tag}  https://www.github.com/${gh_repo}.git#main

# Tag the Docker image with the given Docker Hub repository
docker image tag ${docker_tag} ${dockerhub_repo}

# Push the Docker image to the given Docker Hub repository
docker push ${dockerhub_repo}

# Check if the push was successful
if [ $? = 0 ]; then
  echo "Successfully pushing new image to ${dockerhub_repo}"; exit 0
fi