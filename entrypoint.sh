#!/bin/bash

cat <<EOF
Welcome to NGINX reverse proxy for MobSF
EOF

if [ -z ${DH_SIZE+x} ]
then
  >&2 echo ">> no \$DH_SIZE specified using default"
  DH_SIZE="2048"
fi


DH="/etc/nginx/external/pki/dh.pem"

if [ ! -e "$DH" ]
then
  echo ">> seems like the first start of nginx"
  echo ">> doing some preparations..."
  echo ""

  echo ">> generating $DH with size: $DH_SIZE"
  openssl dhparam -out "$DH" $DH_SIZE
fi

if [ ! -e "/etc/nginx/external/pki/cert.pem" ] || [ ! -e "/etc/nginx/external/pki/key.pem" ]
then
  echo ">> generating self signed cert"
  openssl req -x509 -newkey rsa:4086 \
  -subj "/C=XX/ST=XXXX/L=XXXX/O=XXXX/CN=localhost" \
  -keyout "/etc/nginx/external/pki/key.pem" \
  -out "/etc/nginx/external/pki/cert.pem" \
  -days 3650 -nodes -sha256
fi

echo ">> copy /etc/nginx/external/*.conf files to /etc/nginx/conf.d/"
cp /etc/nginx/external/*.conf /etc/nginx/conf.d/ 2> /dev/null > /dev/null
envsubst < /etc/nginx/conf.d/auth.conf > /etc/nginx/conf.d/auth2.conf
rm -f /etc/nginx/conf.d/auth.conf
mv /etc/nginx/conf.d/auth2.conf /etc/nginx/conf.d/auth.conf
cp /etc/nginx/external/auth.htpasswd /etc/nginx/auth.htpasswd

# exec CMD
echo ">> exec docker CMD"
echo "$@"
exec "$@"
#envsubst < auth.conf > /etc/nginx/conf.d/auth.conf
#envsubst < auth.htpasswd > /etc/nginx/auth.htpasswd


