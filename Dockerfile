#FROM azul/zulu-openjdk-alpine:8u222-jre
FROM registry.access.redhat.com/ubi8/openjdk-11

# Instalar Maven
#ENV MAVEN_VERSION="3.6.3"
ENV MAVEN_HOME=/opt/maven
ENV PATH=$MAVEN_HOME/bin:$PATH
RUN wget --no-verbose -O /tmp/apache-maven.tar.gz https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz && \
tar xzf /tmp/apache-maven.tar.gz -C /opt/ && \
ln -s /opt/apache-maven-$MAVEN_VERSION $MAVEN_HOME && \
rm -f /tmp/apache-maven.tar.gz

# Default payara ports to expose
EXPOSE 6900 8080

# Configure environment variables
ENV PAYARA_HOME=/opt/payara \ 
DEPLOY_DIR=/opt/payara/deployments \
SOURCE_DIR=/opt/payara/src 

# Create and set the Payara user and working directory owned by the new user
RUN addgroup payara && \
adduser -D -h ${PAYARA_HOME} -H -s /bin/bash payara -G payara && \
echo payara:payara | chpasswd && \
mkdir -p ${DEPLOY_DIR} && \
mkdir -p ${SOURCE_DIR} && \
chown -R payara:payara ${PAYARA_HOME}
USER payara
COPY src $SOURCE_DIR
COPY config $SOURCE_DIR
COPY pom.xml $SOURCE_DIR
WORKDIR ${PAYARA_HOME}

# Download specific
ENV PAYARA_VERSION=5.201
#ENV PAYARA_VERSION="$PAYARA_VERSION"
RUN wget --no-verbose -O ${PAYARA_HOME}/payara-micro.jar https://repo1.maven.org/maven2/fish/payara/extras/payara-micro/5.201/payara-micro-5.201.ja
#RUN wget --no-verbose -O ${PAYARA_HOME}/payara-micro.jar https://repo1.maven.org/maven2/fish/payara/extras/payara-micro/${PAYARA_VERSION}/payara-micro-${PAYARA_VERSION}.ja


RUN  cd $SOURCE_DIR && mvn -s ./config/settings.xml clean package 
COPY $SOURCE_DIR/target/lab-payaramicro-1.war ${DEPLOY_DIR}

# Default command to run
ENTRYPOINT ["java", "-XX:+UseContainerSupport", "-XX:MaxRAMPercentage=90.0", "-jar", "payara-micro.jar"]
CMD ["--deploymentDir", "/opt/payara/deployments"]