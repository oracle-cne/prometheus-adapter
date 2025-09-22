#!/usr/bin/env bash
export GOPATH=$(go env GOPATH)
name="prometheus-adapter"
GOPATH_SRC=$GOPATH/src/${name}
mkdir -p bin
version="0.12.0"
registry=""container-registry.oracle.com/olcne"
docker_tag=${registry}/${name}:v${version}

ldflags="
        -X main.version=v${version}
        -X github.com/prometheus/common/version.Version=${version}
        -X github.com/prometheus/common/version.Revision=${GIT_REVISION}
        -X github.com/prometheus/common/version.Branch=HEAD
        -X github.com/prometheus/common/version.BuildUser=${BUILD_USER}
        -X github.com/prometheus/common/version.BuildDate=${BUILD_DATE}"

go build -trimpath=false -v -o bin/${name} \
    -ldflags "${ldflags}" \
    cmd/adapter/adapter.go

docker build --pull \
    --build-arg https_proxy=${https_proxy} \
    -t ${docker_tag} -f ./olm/builds/Dockerfile .
docker save -o ${name}.tar ${docker_tag}
