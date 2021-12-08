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

EXPOSE 8080
USER 1001

CMD ["/usr/dumb-init", "./app", "-Dquarkus.http.host=0.0.0.0"]
