#!/usr/bin/env sh
set -ex
cd /tmp
apk update
apk upgrade

PATH=/usr/local/bin:/usr/local/sbin:$PATH

buildDeps='alpine-sdk python-dev'
apk add $buildDeps duplicity python py-pip openssl curl ca-certificates
pip install --upgrade pip
pip install pyrax
apk del $buildDeps
rm -rf /var/cache/apk/*
rm -rf /tmp/*