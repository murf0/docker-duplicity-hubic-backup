#!/usr/bin/with-contenv sh
set -ex
cd /tmp
apk update
apk upgrade

PATH=/usr/local/bin:/usr/local/sbin:$PATH

buildDeps=''
apk add duplicity python openssl curl ca-certificates
pip install pyrax
apk del $buildDeps
rm -rf /var/cache/apk/*
rm -rf /tmp/*

