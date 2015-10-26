#!/usr/bin/with-contenv sh

#build .hubic_credentials
echo "[hubic]" > .hubic_credentials
echo "email = $email" >> .hubic_credentials
echo "password = $password" >> .hubic_credentials
echo "client_id = $client_id" >> .hubic_credentials
echo "client_secret = $client_secret" >> .hubic_credentials
echo "redirect_uri = $redirect_uri" >> .hubic_credentials

#Install GPG-secret key
echo $PRIVATE_KEY > private.key
gpg --allow-secret-key-import --import private.key

#export PASSPHRASE= Set as environment
export SIGN_PASSPHRASE=$PASSPHRASE
#enc_key= set as environment
HOSTNAME=$TUTUM_NODE_HOSTNAME
cd /BACKUP
duplicity --verbosity notice \
--encrypt-key "$enc_key" \
--sign-key "$enc_key" \
--full-if-older-than 14D \
--num-retries 3 \
--asynchronous-upload \
--volsize 100 \
--allow-source-mismatch \
${EXCLUDES}\
"./" "cf+hubic://zBKP_${HOSTNAME}"
duplicity remove-older-than 6M --force "cf+hubic://zBKP_${HOSTNAME}"

export PASSPHRASE=""
export SIGN_PASSPHRASE=""