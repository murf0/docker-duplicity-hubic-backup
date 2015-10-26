FROM sillelien/base-alpine:latest

MAINTAINER Mikael@murf.se

VOLUME [“/BACKUP”]

COPY build.sh /build.sh
RUN chmod 755 /build.sh
RUN /build.sh

COPY duplicity.sh /
RUN chmod 755 duplicity.sh 

ENTRYPOINT ["/duplicity.sh"]