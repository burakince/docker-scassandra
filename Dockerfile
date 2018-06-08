FROM openjdk:8u171-jdk-stretch AS build

LABEL maintainer="Burak Ince <burak.ince@linux.org.tr>"

ENV SCASSANDRA_VERSION=1.1.2

RUN set -x \
  && apt-get update \
  && apt-get install \
    git \
    wget \
    unzip \
    -y \
  && git clone https://github.com/scassandra/scassandra-server \
  && cd scassandra-server \
  && git checkout tags/$SCASSANDRA_VERSION \
  && ./gradlew server:fatJar \
  && mv /scassandra-server/server/build/libs/scassandra-server_2.11-$SCASSANDRA_VERSION-standalone.jar /scassandra-server/server/build/libs/scassandra-server-standalone.jar \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

FROM openjdk:8u171-jre-stretch

COPY --from=build /scassandra-server/server/build/libs/scassandra-server-standalone.jar /scassandra-server-standalone.jar

ENTRYPOINT [ "java", "-jar", "-Dscassandra.binary.listen-address=0.0.0.0", "-Dscassandra.admin.listen-address=0.0.0.0", "/scassandra-server-standalone.jar" ]