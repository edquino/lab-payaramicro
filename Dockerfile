FROM payara/micro:5.2020.7-jdk11
COPY target/gateway-ui.war ${DEPLOY_DIR}
USER root
RUN chown -R payara:payara /etc/
USER payara
RUN mkdir -p /opt/payara/logs
COPY files/logger.properties /opt/payara
COPY files/timezone /etc/timezone
COPY files/localtime /etc/localtime
CMD ["--deploymentDir", "/opt/payara/deployments", "--logProperties", "/opt/payara/logger.properties"]
