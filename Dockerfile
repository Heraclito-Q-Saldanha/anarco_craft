FROM alpine

ENV MINECRAFT_VERSION="1.20.4"

RUN apk -U upgrade
RUN apk add openjdk17-jre-headless curl jq

RUN mkdir -p /opt/minecraft_server && \
    LATEST_VERSION=$(curl -s https://api.papermc.io/v2/projects/paper | jq -r '.versions[-1]') && \
    LATEST_BUILD=$(curl -s https://api.papermc.io/v2/projects/paper/versions/${MINECRAFT_VERSION}/builds | jq -r '.builds | map(select(.channel == "default") | .build) | .[-1]') && \
    JAR_NAME=paper-${LATEST_VERSION}-${LATEST_BUILD}.jar && \
    PAPERMC_URL="https://api.papermc.io/v2/projects/paper/versions/${LATEST_VERSION}/builds/${LATEST_BUILD}/downloads/${JAR_NAME}" && \
    curl -o /opt/minecraft_server/server.jar $PAPERMC_URL

ENV PATH="$PATH:/opt/minecraft_server"

RUN mkdir -p /data
WORKDIR /data

ENTRYPOINT ["java"]

CMD ["-Xmx1024M", "-Xms1024M", "-jar", "/opt/minecraft_server/server.jar", "nogui"]