ARG PLAYGROUND_VERSION
FROM nekyuubi/playground-base-java17:${PLAYGROUND_VERSION}

ARG VERSION=21-SNAPSHOT

RUN set -x && \
    wget -q https://github.com/NetEase/lakehouse-benchmark/releases/download/21/lakehouse-benchmark-${VERSION}.tar && \
    tar -xvf lakehouse-benchmark-${VERSION}.tar -C /opt && \
    rm lakehouse-benchmark-${VERSION}.tar && \
    ln -s /opt/lakehouse-benchmark-${VERSION} /opt/lakehouse-benchmark

WORKDIR /opt/lakehouse-benchmark/
