FROM roboconf/roboconf-agent:latest

# We are already under "/opt/roboconf-agent..."
ARG DM_IP="172.17.0.1"

# Add Karaf features to install at startup
RUN sed -ie "s/featuresBoot\s*=\s*\(.*\)/featuresBoot = management, decanter-collector-jmx, decanter-appender-elasticsearch-rest, \1/g" etc/org.apache.karaf.features.cfg

# Indicate where to get Decanter
RUN echo "decanter=mvn:org.apache.karaf.decanter/apache-karaf-decanter/1.3.0/xml/features" >> etc/org.apache.karaf.features.repos.cfg
RUN sed -ie "s/featuresRepositories\s*=\s*\(.*\)/featuresRepositories = mvn:org.apache.karaf.decanter\/apache-karaf-decanter\/1.3.0\/xml\/features, \1/g" etc/org.apache.karaf.features.cfg

# Add configuration files
# JMX collector
RUN mkdir -p etc/roboconf/cfg-injection
COPY org.apache.karaf.decanter.collector.jmx-local.cfg.tpl etc/roboconf/cfg-injection/

# Elasticsearch
RUN echo "address=http://${DM_IP}:9200" > etc/org.apache.karaf.decanter.appender.elasticsearch.rest.cfg

# Agent configuration is already handled by the super image...
# Except our Docker target cannot pass (at the moment) environment variables. So, let's hard code the configuration. :(

ENV RABBITMQ_PORT_5672_TCP_ADDR="${DM_IP}" \
 RABBITMQ_USER="roboconf" \
 RABBITMQ_PASS="roboconf" \
 MESSAGING_TYPE="rabbitmq"

# For parameters that are not handled by our super image, we could directly
# update configuration files with sed.

# Set the CMD, again
CMD /opt/roboconf-karaf-dist-agent/roboconf-agent-docker-wrapper.sh

