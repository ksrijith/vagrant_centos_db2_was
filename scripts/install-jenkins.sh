#!/bin/sh
. /etc/environment

user=jenkins
group=jenkins
uid=1010
gid=1010
http_port=8080
agent_port=56000

export JENKINS_HOME=/var/jenkins_home
export JENKINS_SLAVE_AGENT_PORT=${agent_port}
export JENKINS_UC=https://updates.jenkins.io
export JENKINS_UC_EXPERIMENTAL=https://updates.jenkins.io/experimental
export COPY_REFERENCE_FILE_LOG=$JENKINS_HOME/copy_reference_file.log

groupadd -g ${gid} ${group}
useradd -d "$JENKINS_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user}
mkdir -p /var/jenkins_home
mkdir -p /usr/share/jenkins/ref/init.groovy.d
TINI_VERSION=v0.16.1
cp /share/soft/jenkins/tini_pub.gpg /var/jenkins_home/tini_pub.gpg
curl -fsSL https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static-amd64 -o /sbin/tini \
  && curl -fsSL https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static-amd64.asc -o /sbin/tini.asc \
  && gpg --import /var/jenkins_home/tini_pub.gpg \
  && gpg --verify /sbin/tini.asc \
  && rm -rf /sbin/tini.asc /root/.gnupg \
  && chmod +x /sbin/tini
  
cp /share/soft/jenkins/init.groovy /usr/share/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy
wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war -O /usr/share/jenkins/jenkins.war

mkdir -p /usr/share/jenkins/ref
chown -R ${user} "$JENKINS_HOME" /usr/share/jenkins/ref

cp /share/soft/jenkins/plugins.txt /usr/share/jenkins/ref
cp /share/soft/jenkins/config.xml.override /usr/share/jenkins/ref
cp /share/soft/jenkins/install-plugins.sh /usr/local/bin/
cp /share/soft/jenkins/jenkins-support /usr/local/bin/
cp /share/soft/jenkins/jenkins.sh /usr/local/bin/jenkins.sh
cp /share/soft/jenkins/tini-shim.sh /bin/tini
cp /share/soft/jenkins/plugins.sh /usr/local/bin/plugins.sh

/usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
cp /share/soft/jenkins/jenkins.service /etc/systemd/system/jenkins.service
systemctl start jenkins.service
systemctl enable jenkins.service
