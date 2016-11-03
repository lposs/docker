FROM java:8

MAINTAINER warren.strange@forgerock.com

WORKDIR /opt

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/


# Path to secret file that contains the cn=Directory Manager password
# Used to configure the image
# Mount a docker volume or K8S secret volume on /var/secrets/opendj
# This is the path to the password file
# If no volume is mounted, a default password is set
ENV DIR_MANAGER_PW_FILE /var/secrets/opendj/dirmanager.pw

ENV MVN_REPO=https://maven.forgerock.org/repo/repo/org/forgerock/opendj
ENV OPENDJ_VERSION=4.0.0-SNAPSHOT

# Example of how you can download the DJ zip file from maven
#RUN curl $MVN_REPO/opendj-server-legacy/$OPENDJ_VERSION/opendj-server-legacy-$OPENDJ_VERSION.zip -o /tmp/opendj.zip

# This assumes the dj zip file is in this directory
ADD opendj.zip /tmp/


# Creating instance.loc consolidates the writable directories under one root
# We also create the extensions directory
# We set a dir manager default password value here, but this is almost
# certainly not what you want. This hard coded path to the password
# should get over mounted by a secret volume with the "real" password. See the README
RUN unzip /tmp/opendj.zip -d /opt  && rm /tmp/opendj.zip && \
    echo "/opt/opendj/data" > /opt/opendj/instance.loc  && \
    mkdir -p /opt/opendj/data/lib/extensions && \
    mkdir -p /var/secrets/opendj && \
    echo "password"  > ${DIR_MANAGER_PW_FILE}


WORKDIR /opt/opendj

ADD Dockerfile /

ADD bootstrap/ /opt/opendj/bootstrap/



EXPOSE 389 636 4444 8989

ADD run.sh /opt/opendj/run.sh


CMD ["/opt/opendj/run.sh"]
