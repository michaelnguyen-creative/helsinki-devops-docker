#!/bin/bash
# If no argument provided, the script will exit with status code 1
test $# = 0 && (echo "Provide a GitHub repo & Docker hub registry address"; exit 1)

gh_repo=$1
dockerhub_repo=$2

if [ -z ${gh_repo} ] || [ -z ${dockerhub_repo} ]; then
  echo "Both arguments must be strings" && exit 1
fi

docker_tag="${gh_repo}:latest"
docker build -t ${docker_tag}  https://www.github.com/${gh_repo}.git#main
docker image tag ${docker_tag} ${dockerhub_repo}
docker push ${dockerhub_repo}

if [ $? = 0 ]; then
  echo "Successfully pushing new image to ${dockerhub_repo}"; exit 0
fi