#!/bin/bash
# must be adapted especially the COMMON NAME must match the server_name in the nginx.conf
# create server key and signing request (CSR) (domain in server_cert.conf must match server_name in nginx.conf)
cd nginx/certs;
echo "create server_cert_custom.conf with DOMAIN_NAME from .env"
source ../../.env
SERVER_CERT_CUSTOM_CONF=server_cert_custom.conf
sed -e "s/DOMAIN_NAME/$DOMAIN_NAME/g" ../server_cert.conf > $SERVER_CERT_CUSTOM_CONF
echo "create server key and signing request";
openssl req -newkey rsa:4096 -nodes -keyout web.key -out web.csr -config $SERVER_CERT_CUSTOM_CONF
# sign the server cert with the root cert and key
echo "sign server cert with root cert";
openssl x509 -req -in web.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out web.crt -days 365 -sha256 -extensions req_ext -extfile $SERVER_CERT_CUSTOM_CONF;
rm $SERVER_CERT_CUSTOM_CONF;
cd ../..;
