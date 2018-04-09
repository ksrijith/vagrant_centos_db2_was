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

## Instructions
1. Download and copy required installation files to required directory:
    The DB2 Installer should be placed as the share/soft/db2/db2.tar.gz
    The file can be downloaded from:
    https://www.ibm.com/developerworks/downloads/im/db2express/

    Download the following version:
    ### DB2 Express-C for Linux x64
    ### Version  11.1 

    Select the following file to download:
    ### DB2 Express-C
    ### v11.1_linuxx64_expc.tar.gz  (680 MB)

    Rename the downloaded file as db2.tar.gz  

    Websphere, java and jenkins will be downloaded if not  found and copied to the share directory for future builds.   

2. Install required vagrant plugins:  
    a. vagrant-vbguest: `vagrant plugin install vagrant-vbguest`  
    b. vagrant-reload: `vagrant plugin install vagrant-reload`  
  
3. Bring up vagrnat box:  
    `vagrant up`

# Issues
Sometimes the `vagrant up` command fails on the first run. In that case please follow the steps below:  
1. SSH: `vagrant ssh`
2. Update yum cache: `sudo yum update`
3. logout: `exit`
4. Reload: `vagrant reload`
5. Provision: `vagrant provision`
