#!/usr/bin/env bash
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e

APACHE_MIRROR=${APACHE_MIRROR:-https://mirrors.cloud.tencent.com/apache}
MAVEN_MIRROR=${MAVEN_MIRROR:-https://mirrors.cloud.tencent.com/maven}
BUILD_CMD="docker build"

if [ $BUILDX ]; then
  echo "Using buildx to build cross-platform images"
  BUILD_CMD="docker buildx build --platform=linux/amd64,linux/arm64 --push"
fi

SELF_DIR="$(cd "$(dirname "$0")"; pwd)"

source "${SELF_DIR}/.env"

${BUILD_CMD} \
  --build-arg PLAYGROUND_VERSION=${PLAYGROUND_VERSION} \
  --build-arg APACHE_MIRROR=${APACHE_MIRROR} \
  --build-arg MAVEN_MIRROR=${MAVEN_MIRROR} \
  --build-arg KYUUBI_VERSION=${KYUUBI_VERSION} \
  --file "${SELF_DIR}/docker/playground-base.Dockerfile" \
  --tag nekyuubi/playground-base:${PLAYGROUND_VERSION} \
  "${SELF_DIR}/docker" $@

${BUILD_CMD} \
  --build-arg PLAYGROUND_VERSION=${PLAYGROUND_VERSION} \
  --build-arg APACHE_MIRROR=${APACHE_MIRROR} \
  --build-arg MAVEN_MIRROR=${MAVEN_MIRROR} \
  --build-arg KYUUBI_VERSION=${KYUUBI_VERSION} \
  --build-arg AWS_JAVA_SDK_VERSION=${AWS_JAVA_SDK_VERSION} \
  --build-arg HADOOP_VERSION=${HADOOP_VERSION} \
  --file "${SELF_DIR}/docker/playground-hadoop.Dockerfile" \
  --tag nekyuubi/playground-hadoop:${PLAYGROUND_VERSION} \
  "${SELF_DIR}/docker" $@

${BUILD_CMD} \
  --build-arg PLAYGROUND_VERSION=${PLAYGROUND_VERSION} \
  --build-arg APACHE_MIRROR=${APACHE_MIRROR} \
  --build-arg MAVEN_MIRROR=${MAVEN_MIRROR} \
  --build-arg KYUUBI_VERSION=${KYUUBI_VERSION} \
  --build-arg HIVE_VERSION=${HIVE_VERSION} \
  --build-arg MYSQL_VERSION=${MYSQL_VERSION} \
  --file "${SELF_DIR}/docker/playground-metastore.Dockerfile" \
  --tag nekyuubi/playground-metastore:${PLAYGROUND_VERSION} \
  "${SELF_DIR}/docker" $@

${BUILD_CMD} \
  --build-arg PLAYGROUND_VERSION=${PLAYGROUND_VERSION} \
  --build-arg APACHE_MIRROR=${APACHE_MIRROR} \
  --build-arg MAVEN_MIRROR=${MAVEN_MIRROR} \
  --build-arg KYUUBI_VERSION=${KYUUBI_VERSION} \
  --build-arg AWS_JAVA_SDK_VERSION=${AWS_JAVA_SDK_VERSION} \
  --build-arg CLICKHOUSE_JDBC_VERSION=${CLICKHOUSE_JDBC_VERSION} \
  --build-arg SPARK_HADOOP_VERSION=${SPARK_HADOOP_VERSION} \
  --build-arg MYSQL_VERSION=${MYSQL_VERSION} \
  --build-arg SCALA_BINARY_VERSION=${SCALA_BINARY_VERSION} \
  --build-arg SPARK_VERSION=${SPARK_VERSION} \
  --build-arg SPARK_BINARY_VERSION=${SPARK_BINARY_VERSION} \
  --file "${SELF_DIR}/docker/playground-spark.Dockerfile" \
  --tag nekyuubi/playground-spark:${PLAYGROUND_VERSION} \
  "${SELF_DIR}/docker" $@

${BUILD_CMD} \
  --build-arg PLAYGROUND_VERSION=${PLAYGROUND_VERSION} \
  --build-arg APACHE_MIRROR=${APACHE_MIRROR} \
  --build-arg MAVEN_MIRROR=${MAVEN_MIRROR} \
  --build-arg KYUUBI_VERSION=${KYUUBI_VERSION} \
  --build-arg AWS_JAVA_SDK_VERSION=${AWS_JAVA_SDK_VERSION} \
  --build-arg KYUUBI_HADOOP_VERSION=${KYUUBI_HADOOP_VERSION} \
  --file "${SELF_DIR}/docker/playground-kyuubi.Dockerfile" \
  --tag nekyuubi/playground-kyuubi:${PLAYGROUND_VERSION} \
  "${SELF_DIR}/docker" $@

${BUILD_CMD} \
  --build-arg PLAYGROUND_VERSION=${PLAYGROUND_VERSION} \
  --build-arg MAVEN_MIRROR=${MAVEN_MIRROR} \
  --build-arg KYUUBI_VERSION=${KYUUBI_VERSION} \
  --build-arg ARCTIC_VERSION=${ARCTIC_VERSION} \
  --build-arg ARCTIC_HADOOP_VERSION=${ARCTIC_HADOOP_VERSION} \
  --build-arg AWS_JAVA_SDK_VERSION=${AWS_JAVA_SDK_VERSION} \
  --file "${SELF_DIR}/docker/playground-ams.Dockerfile" \
  --tag nekyuubi/playground-ams:${PLAYGROUND_VERSION} \
  "${SELF_DIR}/docker" $@
