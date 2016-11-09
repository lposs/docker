# OpenAM Dockerfile
FROM tomcat:8.5-jre8

MAINTAINER warren.strange@forgerock.com

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
WORKDIR $CATALINA_HOME


# Note: By default tomcat does NOT listen on 8443. You must add a custom server.xml file to change this
EXPOSE 8080 8443

ENV MVN_REPO=https://maven.forgerock.org/repo/repo/org/forgerock/openam
ENV OPENAM_VERSION=14.0.0-SNAPSHOT

# Use this to download an OpenAM build from Maven. For faster builds comment this out and use a local war file
# RUN curl $MVN_REPO/openam-server/$OPENAM_VERSION/openam-server-$OPENAM_VERSION.war -o /tmp/openam.war


ADD openam.war  /tmp/openam.war


RUN rm -fr /usr/local/tomcat/webapps/* \
  && unzip /tmp/openam.war -d /usr/local/tomcat/webapps/openam \
  && rm /tmp/openam.war


# For testing Docker builds use local files instead - much faster
# If you want a custom openam.war you can also copy in your war file here

# Premake the path and config dir
RUN mkdir -p /root/openam/openam && mkdir -p /root/.openamcfg \
  && echo "/root/openam" > /root/.openamcfg/AMConfig_usr_local_tomcat_webapps_openam_

# If you want to create an Image that is ready to be bootstrapped to a config
# store you can add a custom boot.json
# This can also be added at runtime by a ConfigMap.
#ADD boot.json /root/openam

# Generate a default keystore for SSL - only needed if you want SSL inside the cluster
# You can mount your own keystore on the ssl/ directory to override this
#RUN mkdir -p /usr/local/tomcat/ssl && \
#   keytool -genkey -noprompt \
#     -keyalg RSA \
#     -alias tomcat \
#     -dname "CN=forgerock.com, OU=ID, O=FORGEROCK, L=Calgary, S=AB, C=CA" \
#     -keystore /usr/local/tomcat/ssl/keystore \
#     -storepass password \
#     -keypass password

# Custom server.xml
# Use this if OpenAM is behind SSL termination and you want port 8080 to be configured as secure
# See the server.xml file for details
#ADD server.xml /usr/local/tomcat/conf/server.xml


# For debugging OpenAM in a container uncomment this
# Use something like  kubectl port-forward POD 5005:5005
# ENV CATALINA_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=5005"


# Settings for tomcat cache.
ADD context.xml /usr/local/tomcat/conf/context.xml
