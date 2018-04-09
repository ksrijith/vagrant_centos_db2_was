#!/bin/bash
yum -y makecache fast
yum -y update
yum -y install wget unzip