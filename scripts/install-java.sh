#!/bin/bash
set -eux;
if [ -f /share/soft/ibm-java.bin ];
then
    cp /share/soft/ibm-java.bin /tmp
else
    JAVA_VERSION="1.8.0_sr5fp10"
    ARCH="$(arch)"
    case "${ARCH}" in
        amd64|x86_64)
            ESUM='59b9eb7ead4d552c07028a2f1aa84947d7cc73c0f21bd2213e8f12683bce32c5'
            YML_FILE='sdk/linux/x86_64/index.yml'
            ;;
        i386)
            ESUM='41aff429d032e4fa173d73730ac961c232abeaa79286cdb51c0a4a59982bdabc'
            YML_FILE='sdk/linux/i386/index.yml'
            ;;
        ppc64el|ppc64le)
            ESUM='a77acfbd5d4d3997b8ef849d7bf0ce559f1eeb43e130051b6ccdcb488e3d4556'
            YML_FILE='sdk/linux/ppc64le/index.yml'
            ;;
        s390)
            ESUM='55a24c33e0f94ff1e83ed259c6acc43a240659b43050992f44bc33ad4971aaa9'
            YML_FILE='sdk/linux/s390/index.yml'
            ;;
        s390x)
            ESUM='3fb233a571f85ec8246769801ddd62d9b8e9dfc1599367bbab580f76c7242d99'
            YML_FILE='sdk/linux/s390x/index.yml'
            ;;
        *)
            echo "Unsupported arch: ${ARCH}"
            exit 1
            ;;
    esac

    BASE_URL="https://public.dhe.ibm.com/ibmdl/export/pub/systems/cloud/runtimes/java/meta/"

    wget -q -U UA_IBM_JAVA_Docker -O /tmp/index.yml ${BASE_URL}/${YML_FILE}
    JAVA_URL=$(cat /tmp/index.yml | sed -n '/'${JAVA_VERSION}'/{n;p}' | sed -n 's/\s*uri:\s//p' | tr -d '\r')
    echo "JAVA_URL: " $JAVA_URL
    wget -q -U UA_IBM_JAVA_Docker -O /tmp/ibm-java.bin ${JAVA_URL}
    echo "${ESUM}  /tmp/ibm-java.bin" | sha256sum -c -
    cp /tmp/ibm-java.bin /share/soft
fi
echo "INSTALLER_UI=silent" > /tmp/response.properties
echo "USER_INSTALL_DIR=/opt/ibm/java" >> /tmp/response.properties
echo "LICENSE_ACCEPTED=TRUE" >> /tmp/response.properties
mkdir -p /opt/ibm
chmod +x /tmp/ibm-java.bin
/tmp/ibm-java.bin -i silent -f /tmp/response.properties
rm -f /tmp/response.properties
rm -f /tmp/index.yml
rm -f /tmp/ibm-java.bin
cd /opt/ibm/java/jre/lib
rm -rf icc
