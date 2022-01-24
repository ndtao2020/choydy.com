# --------------> The build image
FROM quay.io/quarkus/ubi-quarkus-mandrel:21.3.0.0-Final-java17 as builder
# copy
WORKDIR /app

# ARG
ARG BASE_URL
ARG FTP_HOST_NAME
ARG FTP_HOST_USER
ARG FTP_HOST_PASS
ARG FTP_HOST_FOLDER

# environment
ENV BASE_URL=${BASE_URL}
ENV FTP_HOST_NAME=${FTP_HOST_NAME}
ENV FTP_HOST_USER=${FTP_HOST_USER}
ENV FTP_HOST_PASS=${FTP_HOST_PASS}
ENV FTP_HOST_FOLDER=${FTP_HOST_FOLDER}

ENV VUE_APP_PROXY=https://choydy.com
ENV VUE_APP_MAX_SIZE_FETCH=3

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
FROM quay.io/quarkus/quarkus-micro-image:1.0
WORKDIR /work
# set up permissions for user 1001
RUN chown 1001 /work && chmod "g+rwX" /work && chown 1001:root /work
# Copy
COPY --chown=1001:root ./key /work/key
COPY --chown=1001:root --from=builder /app/target/*-runner /work/app
COPY --from=downloader /usr/dumb-init /usr/dumb-init

RUN mkdir -p /work/upload && chown -R 1001:root /work/upload
RUN chmod +x /usr/dumb-init
VOLUME /work/upload

EXPOSE 8080
USER 1001

CMD ["/usr/dumb-init", "./app", "-Dquarkus.http.host=0.0.0.0"]
