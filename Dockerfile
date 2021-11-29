# --------------> The build image
FROM quay.io/quarkus/ubi-quarkus-mandrel:21.3.0.0-Final-java11 as builder
# copy
WORKDIR /app
# copy
COPY ./.mvn ./.mvn
COPY ./src ./src
COPY ./webapp ./webapp
COPY ./mvnw ./mvnw
COPY ./pom.xml ./pom.xml
# build
USER root
RUN chmod +x mvnw && ./mvnw package -Pnative && rm -rf ./src && rm -rf ./webapp && rm -f ./pom.xml

# --------------> The download image
FROM alpine as downloader
# Update
RUN apk add --no-cache wget
RUN wget -O /usr/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64

# --------------> The production image
FROM registry.access.redhat.com/ubi8/ubi-minimal
WORKDIR /work
# Update
RUN microdnf update -y && microdnf clean all && rm -rf /var/cache/yum
RUN chown 1001 /work && chmod "g+rwX" /work && chown 1001:root /work
# Copy
COPY --chown=1001:root ./key /work/key
COPY --chown=1001:root --from=builder /app/target/*-runner /work/app
COPY --from=downloader /usr/dumb-init /usr/dumb-init
RUN chmod +x /usr/dumb-init

ARG PORT
EXPOSE ${PORT}

USER 1001

ARG QUARKUS_KEYSTORE_PATH
ARG QUARKUS_KEYSTORE_ALIAS
ARG QUARKUS_KEYSTORE_PASS
ARG PGHOST
ARG PGPORT
ARG PGDATABASE
ARG PGUSER
ARG PGPASSWORD
ARG REDISHOST
ARG REDISPORT
ARG REDISUSER
ARG REDISPASSWORD

ENV QUARKUS_KEYSTORE_PATH=${QUARKUS_KEYSTORE_PATH}
ENV QUARKUS_KEYSTORE_ALIAS=${QUARKUS_KEYSTORE_ALIAS}
ENV QUARKUS_KEYSTORE_PASS=${QUARKUS_KEYSTORE_PASS}
ENV QUARKUS_DATASOURCE_USERNAME=${PGUSER}
ENV QUARKUS_DATASOURCE_PASSWORD=${PGPASSWORD}
ENV QUARKUS_DATASOURCE_JDBC_URL=jdbc:postgresql://${PGHOST}:${PGPORT}/${PGDATABASE}
ENV QUARKUS_REDIS_HOSTS=redis://${REDISUSER}:${REDISPASSWORD}@${REDISHOST}:${REDISPORT}

CMD ["/usr/dumb-init", "./app", "-Dquarkus.http.host=0.0.0.0"]
