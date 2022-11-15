ARG KYUUBI_VERSION

FROM nekyuubi/kyuubi-playground-base:${KYUUBI_VERSION}

ARG AWS_JAVA_SDK_VERSION
ARG ARCTIC_VERSION
ARG ARCTIC_RELEASE=v0.3.2-rc1
ARG ARCTIC_HADOOP_VERSION

ARG MAVEN_MIRROR

ENV ARCTIC_HOME=/opt/arctic
ENV HADOOP_CONF_DIR=/etc/hadoop/conf

RUN set -x && \
    wget -q https://github.com/NetEase/arctic/releases/download/${ARCTIC_RELEASE}/arctic-${ARCTIC_VERSION}-bin.zip && \
    unzip arctic-${ARCTIC_VERSION}-bin.zip -d /opt && \
    rm arctic-${ARCTIC_VERSION}-bin.zip && \
    ln -s /opt/arctic-${ARCTIC_VERSION} ${ARCTIC_HOME} && \
    HADOOP_CLOUD_STORAGE_JAR_NAME=hadoop-cloud-storage && \
    wget -q ${MAVEN_MIRROR}/org/apache/hadoop/${HADOOP_CLOUD_STORAGE_JAR_NAME}/${ARCTIC_HADOOP_VERSION}/${HADOOP_CLOUD_STORAGE_JAR_NAME}-${ARCTIC_HADOOP_VERSION}.jar -P ${ARCTIC_HOME}/lib && \
    HADOOP_AWS_JAR_NAME=hadoop-aws && \
    wget -q ${MAVEN_MIRROR}/org/apache/hadoop/${HADOOP_AWS_JAR_NAME}/${ARCTIC_HADOOP_VERSION}/${HADOOP_AWS_JAR_NAME}-${ARCTIC_HADOOP_VERSION}.jar -P ${ARCTIC_HOME}/lib && \
    AWS_JAVA_SDK_BUNDLE_JAR_NAME=aws-java-sdk-bundle && \
    wget -q ${MAVEN_MIRROR}/com/amazonaws/${AWS_JAVA_SDK_BUNDLE_JAR_NAME}/${AWS_JAVA_SDK_VERSION}/${AWS_JAVA_SDK_BUNDLE_JAR_NAME}-${AWS_JAVA_SDK_VERSION}.jar -P ${ARCTIC_HOME}/lib

CMD ["bash","-c","/opt/arctic/bin/ams.sh start && tail -f /dev/null"]
