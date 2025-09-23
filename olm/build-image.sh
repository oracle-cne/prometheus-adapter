#!/usr/bin/env bash

name="prometheus-adapter"
version="0.12.0"
registry=""container-registry.oracle.com/olcne"
docker_tag=${registry}/${name}:v${version}

podman build --pull \
    --build-arg https_proxy=${https_proxy} \
    -t ${docker_tag} -f ./olm/builds/Dockerfile .
podman save -o ${name}.tar ${docker_tag}
