# Main container
# FROM selenium/standalone-chrome:3.141
FROM selenium/standalone-chrome:106.0-20220929
USER root

ENV START_XVFB=false
# 100 is more than enough for a single server

RUN mkdir -p /usr/share/man/man1 && \
	apt-get update && \
	apt-get install -y openjdk-8-jdk-headless maven vim git && \
	apt-get clean

RUN echo "set encoding=utf-8" >> /etc/vim/vimrc

COPY ./ /jitsi-meet-torture/
RUN cd /jitsi-meet-torture && \
	mvn test -Djitsi-meet.tests.toRun=MalleusJitsificus -Dmaven.test.skip.exec=true

RUN mv /usr/bin/google-chrome /usr/bin/google-chrome-bin
COPY rootfs/ /
RUN chmod 755 /usr/bin/google-chrome
RUN chmod 755 /start.sh

ENTRYPOINT ["/start.sh"]


