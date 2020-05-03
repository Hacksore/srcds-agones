#!/bin/bash

# was debugging microk8s
echo "Checking if we have internet"
curl -s 'https://api.ipify.org?format=json'

${STEAMAPPDIR}/srcds_run \
  -game garrysmod \
  -maxplayers $SRCDS_MAXPLAYERS \
  +map $SRCDS_STARTMAP \
  +sv_setsteamaccount $SRCDS_TOKEN \
  +hostname "$HOSTNAME"