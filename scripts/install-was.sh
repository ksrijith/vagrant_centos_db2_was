#!/bin/bash
set -eux;
if [ -f /share/soft/wlp.zip ];
then
    cp /share/soft/wlp.zip /tmp
else
export LIBERTY_VERSION=17.0.0_04
    LIBERTY_URL=${LIBERTY_URL:-$(wget -q -O - https://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/wasdev/downloads/wlp/index.yml  | grep $LIBERTY_VERSION -A 6 | sed -n 's/\s*kernel:\s//p' | tr -d '\r' )}  \
        && wget $LIBERTY_URL -U UA-IBM-WebSphere-Liberty-Docker -O /tmp/wlp.zip
    cp /tmp/wlp.zip /share/soft
fi

unzip -q /tmp/wlp.zip -d /opt/ibm
rm /tmp/wlp.zip
export PATH=/opt/ibm/java/bin:/opt/ibm/wlp/bin:$PATH
export LOG_DIR=/logs \
export WLP_OUTPUT_DIR=/opt/ibm/wlp/output

/opt/ibm/wlp/bin/server create \
    && rm -rf $WLP_OUTPUT_DIR/.classCache /output/workarea

mkdir /logs \
    && ln -s $WLP_OUTPUT_DIR/defaultServer /output \
    && ln -s /opt/ibm/wlp/usr/servers/defaultServer /config

export LICENSE=accept
cp /scripts/setup-was-server.sh /opt/ibm/wlp/bin
chmod +x /opt/ibm/wlp/bin/setup-was-server.sh
bash /opt/ibm/wlp/bin/setup-was-server.sh

installUtility install --acceptLicense \
    appSecurity-2.0 bluemixUtility-1.0 collectiveMember-1.0 ldapRegistry-3.0 \
    localConnector-1.0 microProfile-1.0 microProfile-1.2 monitor-1.0 restConnector-1.0 \
    requestTiming-1.0 restConnector-2.0 sessionDatabase-1.0 ssl-1.0 transportSecurity-1.0 \
    webCache-1.0 webProfile-7.0 adminCenter-1.0 collectiveController-1.0 appSecurityClient-1.0 javaee-7.0 javaeeClient-7.0\
 && rm -rf /output/workarea /output/logs

chmod -R 777 /opt/ibm/wlp
chmod -R 777 $LOG_DIR
cp /scripts/was/server.xml /config/
