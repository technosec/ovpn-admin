#!/usr/bin/env bash
set -eo pipefail

dns_container_id="$(docker ps | grep "$OVPN_DNS_CONTAINER_NAME_PATTERN" | awk '{ print $1 }' 2> /dev/null)"
if [ "$dns_container_id" != "" ]; then
  echo "Found running DNS container $dns_container_id"
#  existing_network_name="$(docker inspect "$dns_container_id" | jq -r '.[0].NetworkSettings.Networks | keys | .[0] ')"
#  echo "Found network '$existing_network_name' connected to '$dns_container_id'"
#  vpn_container_id="$(docker ps | grep "${OVPN_COMPOSE_NAME}" | grep "openvpn" | awk '{ print $1 }' 2> /dev/null)"
#  echo "Connecting network '$existing_network_name' to $vpn_container_id"
#  docker network connect "$existing_network_name" "$vpn_container_id"
  echo "Connecting network '${OVPN_COMPOSE_NAME}' to $dns_container_id"
  docker network connect "${OVPN_COMPOSE_NAME}_ovpn-net" "$dns_container_id"
fi
