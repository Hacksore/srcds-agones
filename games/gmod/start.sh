#!/bin/bash

# was debugging microk8s
echo "Checking if we have internet"
curl -s 'https://api.ipify.org?format=json'

# Tell sidecar everything is artificially "ok" until I write something better
# to check that the server is actually up by reading the console output
for i in {1..3}; do
  curl -s -d "{}" -H "Content-Type: application/json" -X POST http://localhost:${AGONES_SDK_HTTP_PORT}/ready
  sleep 1
done

${STEAMAPPDIR}/srcds_run \
  -game garrysmod \
  -maxplayers $SRCDS_MAXPLAYERS \
  +map $SRCDS_STARTMAP \
  +sv_setsteamaccount $SRCDS_TOKEN \
  +hostname "$HOSTNAME"