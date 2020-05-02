#!/bin/bash

${STEAMAPPDIR}/srcds_run \
  -game garrysmod \
  -maxplayers $SRCDS_MAXPLAYERS \
  +map $SRCDS_STARTMAP \
  +sv_setsteamaccount $SRCDS_TOKEN \
  +hostname "$HOSTNAME"