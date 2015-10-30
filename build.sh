#!/usr/bin/env sh
if [ -z ${DBG} ]; then set -e; else set -ex; fi
export TERM=dumb
cd /tmp

if [ "x${ORGANISATION_NAME}" = "x" ]; then echo "YOU MUST SET ALL ENVIRONMENT VARIABLES"; exit 254; fi

apt-get update
apt-get upgrade -y

PATH=/usr/local/bin:/usr/local/sbin:$PATH
buildDeps="python-dev wget lftp ncftp  lftp python-boto python-paramiko python-pycryptopp"
apt-get install -y $buildDeps librsync-dev python-pip
wget https://code.launchpad.net/duplicity/0.7-series/0.7.05/+download/duplicity-0.7.05.tar.gz
tar -zxf duplicity-0.7.05.tar.gz
cd duplicity*
python ./setup.py install


pip install --upgrade pip
pip install pyrax
pip install furl --upgrade
pip install lockfile


apt-get -y remove $buildDeps
apt-get -y autoremove 

apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*