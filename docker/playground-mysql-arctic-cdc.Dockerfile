ARG PLAYGROUND_VERSION
FROM nekyuubi/playground-base:${PLAYGROUND_VERSION}

RUN set -x && \
    mkdir -p /opt/lakehouse_benchmark_ingestion && \
    wget -q https://github.com/NetEase/lakehouse-benchmark-ingestion/releases/download/1.0/lakehouse_benchmark_ingestion.tar.gz && \
    tar -xzf lakehouse_benchmark_ingestion.tar.gz -C /opt/lakehouse_benchmark_ingestion && \
    rm lakehouse_benchmark_ingestion.tar.gz

WORKDIR /opt/lakehouse_benchmark_ingestion/
