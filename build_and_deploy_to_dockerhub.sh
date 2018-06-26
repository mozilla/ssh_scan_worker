#!/bin/bash

docker build -t mozilla/ssh_scan_worker .

if [[ "$TRAVIS_BRANCH" == "master" ]]; then
  if [[ "$TRAVIS_PULL_REQUEST" == "false" ]]; then
    docker login -u="$DOCKER_USER" -p="$DOCKER_PASS" ;\
    docker push mozilla/ssh_scan_worker:latest ;\
  else
    exit 0
  fi
else
  exit 0
fi