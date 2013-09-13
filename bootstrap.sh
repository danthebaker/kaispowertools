#!/bin/bash
apt-get update
apt-get install -y git make curl software-properties-common

make all

#echo
#echo "Be sure to upload a public key for your user:"
#echo "  cat ~/.ssh/id_rsa.pub | ssh root@$HOSTNAME \"gitreceive upload-key progrium\""
