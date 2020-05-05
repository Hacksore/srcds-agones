#!/bin/bash

# was debugging microk8s
echo "Checking if we have internet"
curl -s 'https://api.ipify.org?format=json'

echo "Starting game server..."

${STEAMAPPDIR}/srcds_run \
  -game garrysmod \
  -port $DSG_PORT \
  -maxplayers $SRCDS_MAXPLAYERS \
  +map $SRCDS_STARTMAP \
  +sv_setsteamaccount $SRCDS_TOKEN \
  +hostname "$HOSTNAME" 2>&1 