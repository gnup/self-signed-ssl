#!/bin/bash

# Config
CA_Vaild_Day=1024
Domain_Vaild_Day=365
CA_Key="./rootCA.key"
CA_Crt="./rootCA.crt"

# Check if CA files exist
if [ -f "$CA_Key" -a -f "$CA_Crt" ]; then
    echo ">>> CA file already exists."
else
    echo ">>> No CA file found, creating new..."
    openssl genrsa -out rootCA.key 4096
    openssl req -x509 -new -nodes -key rootCA.key -sha256 -days $CA_Vaild_Day -out rootCA.crt <<< $'\n\n\n\n\n\n\n\n\n' 
    echo -e "\n\n>>> CA files created successfully and vaild for 1024 days. " 
fi

echo -e "\n>>> Enter the domain name to sign: "
read Domain
echo ">>> Domain to be signed: $Domain"

openssl genrsa -out $Domain.key 2048
openssl req -new -sha256 -key $Domain.key -subj "/C=US/ST=North Carolina/O=ORG/OU=ORG_UNIT/CN=$Domain" -reqexts SAN -config <(cat /etc/ssl/openssl.cnf <(printf "\n[SAN]\nsubjectAltName=DNS:$Domain")) -out $Domain.csr
# Sign the domain certs
openssl x509 -req -extfile <(printf "subjectAltName=DNS:$Domain") -days $Domain_Vaild_Day -in $Domain.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out $Domain.crt -sha256

echo -e "\n\033[32m>>> Signed successfully! NOTE:The domain certs are valid for 365 days.\033[0m"

