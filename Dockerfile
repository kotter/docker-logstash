FROM java:7-jre
MAINTAINER Karl Otterbein <kotter9@gmail.com>

# Install Logstash
ENV LOGSTASH_VERSION 1.5.0
RUN curl -s http://download.elastic.co/logstash/logstash/logstash-$LOGSTASH_VERSION.tar.gz | tar --transform "s/^logstash-$LOGSTASH_VERSION/logstash/" -xvz -C /opt

# Change working dir
WORKDIR /opt/logstash

# Install contrib plugins
RUN bin/plugin install contrib

# Add custom patterns and configs if necessary
ADD opt/logstash/patterns/ /opt/logstash/patterns/
ADD etc/logstash/conf.d/ /etc/logstash/conf.d/

# Starts agent using the provided conf file.  THis will have to be updated to supply your conf, or mount
# external conf directory if you wish to use a seperate set of files external of the container.
CMD ["bin/logstash", "-f", "/etc/logstash/conf.d/"]
