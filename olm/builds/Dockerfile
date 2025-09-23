FROM container-registry.oracle.com/os/oraclelinux:9 AS builder

RUN dnf config-manager --enable ol9_codeready_builder && \
    dnf -y install git make golang hostname && \
    go version

# Copy the contents of the repository
COPY . /workspace/go/src/github.com/oracle-cne/prometheus-adapter

ENV GOPATH=/workspace/go CGO_ENABLED=0
ENV GOPATH_SRC=$GOPATH/src/github.com/oracle-cne/prometheus-adapter
WORKDIR /workspace/go/src/github.com/oracle-cne/prometheus-adapter

RUN git config --global --add safe.directory $(pwd) && \
    sh olm/go-build.sh

FROM container-registry.oracle.com/os/oraclelinux:9-slim

COPY LICENSE NOTICE THIRD_PARTY_LICENSES.txt olm/SECURITY.md /usr/share/licenses/
COPY --from=builder /workspace/go/src/github.com/oracle-cne/prometheus-adapter/bin/prometheus-adapter /usr/bin/prometheus-adapter

RUN microdnf update -y && \
    microdnf clean all && \
    test -d /LICENSES || ln -s /usr/share/licenses /LICENSES

USER nobody

ENTRYPOINT  [ "/usr/bin/prometheus-adapter" ]
