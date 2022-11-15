# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ARG PLAYGROUND_VERSION

FROM nekyuubi/playground-base:${PLAYGROUND_VERSION}

ARG AWS_JAVA_SDK_VERSION
ARG KYUUBI_VERSION
ARG SPARK_HADOOP_VERSION
ARG MYSQL_VERSION
ARG SCALA_BINARY_VERSION
ARG SPARK_VERSION
ARG SPARK_BINARY_VERSION

ARG APACHE_MIRROR
ARG MAVEN_MIRROR

ENV SPARK_HOME=/opt/spark
ENV HADOOP_CONF_DIR=/etc/hadoop/conf
ENV HIVE_CONF_DIR=/etc/hive/conf
ENV SPARK_CONF_DIR=/etc/spark/conf

RUN set -x && \
    wget -q ${APACHE_MIRROR}/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.2.tgz && \
    tar -xzf spark-${SPARK_VERSION}-bin-hadoop3.2.tgz -C /opt && \
    ln -s /opt/spark-${SPARK_VERSION}-bin-hadoop3.2 ${SPARK_HOME} && \
    rm spark-${SPARK_VERSION}-bin-hadoop3.2.tgz && \
    SPARK_HADOOP_CLOUD_JAR_NAME=spark-hadoop-cloud_${SCALA_BINARY_VERSION} && \
    wget -q https://repository.cloudera.com/artifactory/cloudera-repos/org/apache/spark/spark-hadoop-cloud_2.12/3.1.1.3.1.7290.3-87/spark-hadoop-cloud_2.12-3.1.1.3.1.7290.3-87.jar -P ${SPARK_HOME}/jars && \
    HADOOP_CLOUD_STORAGE_JAR_NAME=hadoop-cloud-storage && \
    wget -q ${MAVEN_MIRROR}/org/apache/hadoop/${HADOOP_CLOUD_STORAGE_JAR_NAME}/${SPARK_HADOOP_VERSION}/${HADOOP_CLOUD_STORAGE_JAR_NAME}-${SPARK_HADOOP_VERSION}.jar -P ${SPARK_HOME}/jars && \
    HADOOP_AWS_JAR_NAME=hadoop-aws && \
    wget -q ${MAVEN_MIRROR}/org/apache/hadoop/${HADOOP_AWS_JAR_NAME}/${SPARK_HADOOP_VERSION}/${HADOOP_AWS_JAR_NAME}-${SPARK_HADOOP_VERSION}.jar -P ${SPARK_HOME}/jars && \
    AWS_JAVA_SDK_BUNDLE_JAR_NAME=aws-java-sdk-bundle && \
    wget -q ${MAVEN_MIRROR}/com/amazonaws/${AWS_JAVA_SDK_BUNDLE_JAR_NAME}/${AWS_JAVA_SDK_VERSION}/${AWS_JAVA_SDK_BUNDLE_JAR_NAME}-${AWS_JAVA_SDK_VERSION}.jar -P ${SPARK_HOME}/jars && \
    MYSQL_JAR_NAME=mysql-connector-java && \
    wget -q ${MAVEN_MIRROR}/mysql/${MYSQL_JAR_NAME}/${MYSQL_VERSION}/${MYSQL_JAR_NAME}-${MYSQL_VERSION}.jar -P ${SPARK_HOME}/jars && \
    TPCDS_CONNECTOR_JAR_NAME=kyuubi-spark-connector-tpcds_${SCALA_BINARY_VERSION} && \
    wget -q ${MAVEN_MIRROR}/org/apache/kyuubi/${TPCDS_CONNECTOR_JAR_NAME}/${KYUUBI_VERSION}/${TPCDS_CONNECTOR_JAR_NAME}-${KYUUBI_VERSION}.jar -P ${SPARK_HOME}/jars && \
    TPCH_CONNECTOR_JAR_NAME=kyuubi-spark-connector-tpch_${SCALA_BINARY_VERSION} && \
    wget -q ${MAVEN_MIRROR}/org/apache/kyuubi/${TPCH_CONNECTOR_JAR_NAME}/${KYUUBI_VERSION}/${TPCH_CONNECTOR_JAR_NAME}-${KYUUBI_VERSION}.jar -P ${SPARK_HOME}/jars && \
    wget -q https://github.com/NetEase/arctic/releases/download/v0.3.2-rc1/arctic-spark_3.1-runtime-0.3.2.jar -P ${SPARK_HOME}/jars
