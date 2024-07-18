FROM alpine

RUN apk -U upgrade
RUN apk add openjdk21-jre-headless

RUN mkdir -p /data
WORKDIR /data

ENTRYPOINT ["java"]

CMD ["-Xmx1024M", "-Xms1024M", "-jar", "server.jar", "nogui"]