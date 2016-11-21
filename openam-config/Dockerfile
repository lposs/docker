# Container that configures OpenAM
# Includes configurator, and will eventually contain amster / REST based config
FROM openjdk:8-jre


ENV MVN_REPO=https://maven.forgerock.org/repo/repo/org/forgerock/openam
ENV OPENAM_VERSION=14.0.0-SNAPSHOT

# Use this to download from Maven
#RUN curl $MVN_REPO/openam-distribution-ssoconfiguratortools/$OPENAM_VERSION/openam-distribution-ssoconfiguratortools-$OPENAM_VERSION.zip \
#       -o /tmp/ssoconfig.zip \

ADD ssoconfig.zip /tmp

RUN unzip /tmp/ssoconfig.zip -d /var/tmp/ssoconfig  && rm /tmp/ssoconfig.zip

WORKDIR /var/tmp

# Download AM configurator from maven build

COPY config.sh /var/tmp/
COPY amster.sh /var/tmp/

CMD ["/var/tmp/config.sh"]



