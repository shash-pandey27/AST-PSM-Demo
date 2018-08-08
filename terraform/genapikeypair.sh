#!/bin/bash

api_keyname="oci_api_key.pem"
apipub_keyname="oci_api_key_public.pem"
api_keylocation="$HOME/.oci"

gen_apikey()
{
cd $HOME
[ -d $api_keylocation ] || mkdir -p $api_keylocation

openssl genrsa -out $api_keylocation/$api_keyname 2048

chmod go-rwx $api_keylocation/$api_keyname
openssl rsa -pubout -in $api_keylocation/$api_keyname -out $api_keylocation/$apipub_keyname
}

echo "Generating OCI API key pair"
gen_apikey

echo "Key pair stored in $api_keylocation"
