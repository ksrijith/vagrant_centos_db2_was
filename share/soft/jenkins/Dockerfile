FROM jenkins/jenkins:lts
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY config.xml.override /usr/share/jenkins/ref/config.xml.override
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
