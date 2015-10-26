#!/usr/bin/env sh
set -ex
trap processUserSig SIGINT
processUserSig() {
  exit 0
}

if [ ! -e /root/.hubic_credentials ]; then
	#build .hubic_credentials
	echo "[hubic]" > /root/.hubic_credentials
	echo "email = $email" >> /root/.hubic_credentials
	echo "password = $password" >> /root/.hubic_credentials
	echo "client_id = $client_id" >> /root/.hubic_credentials
	echo "client_secret = $client_secret" >> /root/.hubic_credentials
	echo "redirect_uri = $redirect_uri" >> /root/.hubic_credentials
fi

export HOSTNAME=$TUTUM_NODE_HOSTNAME
duplicity --version
while true; do
	duplicity --verbosity notice --full-if-older-than 14D --num-retries 3 --asynchronous-upload --volsize 100 --allow-source-mismatch ${EXCLUDES}  "/BACKUP" "cf+hubic://zBKP_${HOSTNAME}"
	duplicity remove-older-than 6M --force "cf+hubic://zBKP_${HOSTNAME}"
	sleep 3600
done 