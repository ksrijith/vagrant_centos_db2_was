# vagrant_centos_db2_was
Vagrant Box with CentOS 7, DB2, WAS Liberty and jenkins installed.

## DB2 instance details:
Install Directory: /opt/ibm/db2
DB: SCDB
User: sterling
Password: strdB231
Command to start DB2: sudo systemctl start db2fmcd.service
Autostart: True

## WAS Installation Details:
Install Directory: /opt/ibm/wlp
Server Name: DefaultServer
Log directory: /log
Config Directory: /config
Dropin directory: /config/dropins
Command to start: server start defaultServer

## Jenkins Installation Details:
Jenkins Home: /var/jenkins_home
Jenkins User: jenkins
Command to start Jenkins: sudo systemctl start jenkins.service
Autostart: true
