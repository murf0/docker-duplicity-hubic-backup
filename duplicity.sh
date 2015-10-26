#!/usr/bin/env sh
set -ex
if [ ! -e ~/.hubic_credentials ]; then
	#build .hubic_credentials
	echo "[hubic]" > ~/.hubic_credentials
	echo "email = $email" >> ~/.hubic_credentials
	echo "password = $password" >> ~/.hubic_credentials
	echo "client_id = $client_id" >> ~/.hubic_credentials
	echo "client_secret = $client_secret" >> ~/.hubic_credentials
	echo "redirect_uri = $redirect_uri" >> ~/.hubic_credentials
fi

export SIGN_PASSPHRASE=$PASSPHRASE
export HOSTNAME=$TUTUM_NODE_HOSTNAME

cd /BACKUP
duplicity --verbosity notice --full-if-older-than 14D --num-retries 3 --asynchronous-upload --volsize 100 --allow-source-mismatch ${EXCLUDES}  "./" "cf+hubic://zBKP_${HOSTNAME}"
duplicity remove-older-than 6M --force "cf+hubic://zBKP_${HOSTNAME}"

export PASSPHRASE=""
export SIGN_PASSPHRASE=""