ARG KYUUBI_VERSION

FROM nekyuubi/kyuubi-playground-base:${KYUUBI_VERSION}

ARG ARCTIC_VERSION
ARG ARCTIC_RELEASE
ARG MAVEN_MIRROR

WORKDIR /usr/local/ams

RUN wget https://github.com/NetEase/arctic/releases/download/${ARCTIC_RELEASE}/arctic-${ARCTIC_VERSION}-bin.zip \
    && unzip arctic-${ARCTIC_VERSION}-bin.zip \
    && rm arctic-${ARCTIC_VERSION}-bin.zip \
    && ln -s arctic-${ARCTIC_VERSION} arctic

WORKDIR /usr/local/ams/arctic

RUN cd lib \
    && wget ${MAVEN_MIRROR}/org/apache/hadoop/hadoop-cloud-storage/2.9.2/hadoop-cloud-storage-2.9.2.jar \
    && wget ${MAVEN_MIRROR}/org/apache/hadoop/hadoop-aws/2.9.2/hadoop-aws-2.9.2.jar \
    && wget ${MAVEN_MIRROR}/com/amazonaws/aws-java-sdk-bundle/1.11.119/aws-java-sdk-bundle-1.11.119.jar

CMD ["bash","-c","./bin/ams.sh start && tail -f /dev/null"]


