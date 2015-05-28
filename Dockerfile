FROM develar/java
MAINTAINER Karl Otterbein <kotter9@gmail.com>

# Install Logstash
ENV LOGSTASH_VER 1.5.0
RUN apk add --update curl && \
    apk add --update tar && \
    apk add --update bash && \
    rm -f /var/cache/apk/*

RUN mkdir /opt && \
    curl -s http://download.elastic.co/logstash/logstash/logstash-$LOGSTASH_VER.tar.gz | tar --transform "s/^logstash-$LOGSTASH_VER/logstash/" -xvz -C /opt

# Change working dir
WORKDIR /opt/logstash

# update plugins
RUN bin/plugin update

# Start Logstash- all custom configs should be maintained outside continer.
CMD ["bin/logstash", "-e", "input { stdin { } } output { stdout { codec => rubydebug } }"]
