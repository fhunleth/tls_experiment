#!/bin/sh


openssl ecparam -genkey -name prime256v1 -out signer-key.pem
openssl req -new -x509 -sha256 -days 730 -key signer-key.pem -out signer.pem


openssl ecparam -genkey -name prime256v1 -out server-key.pem
openssl req -new -x509 -sha256 -days 730 -key server-key.pem -out server.pem

openssl ecparam -genkey -name prime256v1 -out device-key.pem
openssl req -new -key device-key.pem -out device.csr
openssl x509 -req -days 3650 -sha256 -in device.csr -CA signer.pem -CAkey signer-key.pem -set_serial 1234 -out device.pem

