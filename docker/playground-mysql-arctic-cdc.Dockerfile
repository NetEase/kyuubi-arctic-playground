ARG PLAYGROUND_VERSION
FROM nekyuubi/playground-base:${PLAYGROUND_VERSION}

WORKDIR /usr/lib/benchmark-ingestion
RUN wget https://github.com/NetEase/lakehouse-benchmark-ingestion/releases/download/1.0/lakehouse_benchmark_ingestion.tar.gz && \
    tar -zxvf lakehouse_benchmark_ingestion.tar.gz && rm -rf lakehouse_benchmark_ingestion.tar.gz