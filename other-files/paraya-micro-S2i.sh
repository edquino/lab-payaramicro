#!/bin/bash

BUILDER_IMAGE_VERSION=0.0.1
if [ -z "$1"]
then   
    echo "Falta el parametro: payara-micro-s2i.sh THIN_WAR_NAME"
    exit 1
fi

LAUNCH_DIR=$(pwd)
THIN_WAR_NAME=$1
REPOSITORY_PROYECT=https://github.com/edquino/lab-payaramicro.git
set -x

echo "building ${THIN_WAR_NAME}"
mvn clean install
echo "----Deploying ${THIN_WAR_NAME}"
oc new-app quay.io/easanchez/s2i-payara-micro-promerica~${REPOSITORY_PROYECT} --name=${THIN_WAR_NAME} 
echo "----App ${THIN_WAR_NAME} created"
