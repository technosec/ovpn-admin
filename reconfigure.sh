#!/usr/bin/env bash
set -eo pipefail

if [ ! -f .env ]; then
    echo "Please create a .env file"
    exit 1
fi

set -a
source .env
set +a

echo -e "$OVPN_NGINX_HTPASSWD\n" > ./nginx/.htpasswd
envsubst < ./nginx/default.conf.tpl > ./nginx/default.conf
envsubst < ./ovpn_config/openvpn.conf.tpl > ./ovpn_config/openvpn.conf
