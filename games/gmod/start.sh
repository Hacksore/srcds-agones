#!/bin/bash

# was debugging microk8s
echo "Checking if we have internet"
curl -s 'https://api.ipify.org?format=json'

echo "----"

echo "Starting game server..."

# add port to a config
cd $STEAMAPPDIR/gamemodes && git pull

cd $STEAMAPPDIR/
cp -R $STEAMAPPDIR/gamemodes/. $STEAMAPPDIR/garrysmod/gamemodes

mkdir -p ${STEAMAPPDIR}/garrysmod/data/
echo "{ \"sdkPort\": $AGONES_SDK_HTTP_PORT }" > ${STEAMAPPDIR}/garrysmod/data/agones.json

${STEAMAPPDIR}/srcds_run \
  -game garrysmod \
  -port $DSG_PORT \
  -maxplayers $SRCDS_MAXPLAYERS \
  +map $SRCDS_STARTMAP \
  +sv_setsteamaccount $SRCDS_TOKEN \
  +gamemode "fluffy_dodgeball" \
  +map "gm_flatgrass" \
  +hostname "\"$HOSTNAME\"" 2>&1 