FROM alpine

RUN apk -U upgrade
RUN apk add openjdk21-jre-headless --no-cache

RUN mkdir /data
WORKDIR /data

ENV JVM_XMX=4096M
ENV JVM_XMS=1024M

ENTRYPOINT ["sh", "-c", "java -Xmx${JVM_XMX} -Xms${JVM_XMS} -jar server.jar nogui"]