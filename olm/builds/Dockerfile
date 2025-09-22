FROM container-registry.oracle.com/os/oraclelinux:9-slim

COPY LICENSE NOTICE THIRD_PARTY_LICENSES.txt olm/SECURITY.md /usr/share/licenses/
COPY bin/prometheus-adapter /usr/bin/prometheus-adapter

RUN microdnf update -y && \
    microdnf clean all && \
    test -d /LICENSES || ln -s /usr/share/licenses /LICENSES

USER nobody

ENTRYPOINT  [ "/usr/bin/prometheus-adapter" ]
