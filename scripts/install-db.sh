#!/bin/sh
# Variables
export DB2_FILE=db2.tar.gz
export INSTALL_BASE=/tmp/install
export INSTALLER=expc/db2setup
export SILENT_FILE="/share/soft/db2/db2expc.rsp"
export INSTALL_DIR="/opt/ibm/db2/V11.1"
export INSTALL_FILE="/share/soft/db2/$DB2_FILE"

# Refresh yum cache
yum -y update
mkdir -p $INSTALL_BASE/db2
# copy install file
cp $INSTALL_FILE $INSTALL_BASE/db2

# unzip installer
cd $INSTALL_BASE
pwd
echo $DB2_FILE
tar xvzf db2/$DB2_FILE
chmod -R +x *
cp $SILENT_FILE $INSTALL_BASE

# creating required user for db
# groupadd db2fsdm1
# useradd db2sdfe1 -p dbf123dbf -g db2fsdm1

mkdir -p $INSTALL_DIR

$INSTALLER -u "db2expc.rsp"

rm -rf expc
sudo chmod -R +x /opt/ibm/db2/V11.1
useradd -p $(openssl passwd -1 strdB231) sterling
su - db2inst1 -c  "/opt/ibm/db2/V11.1/bin/db2 create database scdb"
su - db2inst1 -c  "/opt/ibm/db2/V11.1/bin/db2 connect to scdb && db2 GRANT DBADM, CREATETAB, BINDADD, CONNECT, CREATE_NOT_FENCED, IMPLICIT_SCHEMA, LOAD ON DATABASE TO USER sterling && db2 create schema sterling authorization sterling"
su - db2inst1 -c  "/opt/ibm/db2/V11.1/bin/db2 connect to scdb user sterling using strdB231"
