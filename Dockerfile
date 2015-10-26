FROM phusion/baseimage:latest

MAINTAINER Mikael@murf.se

VOLUME [“/BACKUP”]

COPY build.sh /build.sh
RUN chmod 755 /build.sh
RUN /build.sh

RUN mkdir /etc/service/duplicity/
ADD  duplicity.sh /etc/service/duplicity/run
RUN chmod 755 /etc/service/duplicity/run

CMD ["/sbin/my_init"]