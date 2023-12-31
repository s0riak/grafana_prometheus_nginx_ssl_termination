#!/bin/bash
# must be called from within the main directory
mkdir nginx/certs;
cd nginx/certs || exit;
# generate rootCA key (using a password to remember)
echo "create key";
openssl genrsa -des3 -out rootCA.key 4096;
#generate rootCA cert
echo "create root cert";
openssl req -new -x509 -subj "/C=DE" -key rootCA.key -days 365 -sha256 -out rootCA.pem;
# create root CA cert in crt format
echo "create crt format of root cert";
openssl x509 -in rootCA.pem -inform PEM -out rootCA.crt;
cd ../..;
