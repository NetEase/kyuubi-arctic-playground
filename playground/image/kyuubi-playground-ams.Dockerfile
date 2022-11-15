FROM openjdk:8u332-jdk

ARG ARCTIC_VERSION
ARG ARCTIC_RELEASE

WORKDIR /usr/local/ams
RUN apt update \
    && apt-get install -y vim \
    && apt-get install -y net-tools \
    && apt-get install -y telnet

RUN wget https://github.com/NetEase/arctic/releases/download/${ARCTIC_RELEASE}/arctic-${ARCTIC_VERSION}-bin.zip \
    && unzip arctic-${ARCTIC_VERSION}-bin.zip

COPY core-site.xml .

WORKDIR /usr/local/ams/arctic-${ARCTIC_VERSION}/

COPY config.yaml ./conf

RUN cd lib \
    && wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-cloud-storage/2.9.2/hadoop-cloud-storage-2.9.2.jar \
    && wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.9.2/hadoop-aws-2.9.2.jar \
    && wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.119/aws-java-sdk-bundle-1.11.119.jar

CMD ["bash","-c","./bin/ams.sh start && tail -f /dev/null"]


