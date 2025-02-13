#!/usr/bin/env bash
set -eo pipefail

if [ ! -f .env ]; then
    echo "Please create a .env file"
    exit 1
fi

set -a
source .env
set +a

docker-compose -p "$OVPN_COMPOSE_NAME" down "$@"

for script_file in ./stop.d/*.sh
do
   echo "Sourcing ${script_file}"
   source "${script_file}"
done
