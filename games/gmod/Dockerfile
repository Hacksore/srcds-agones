###########################################################
# Dockerfile that builds a GMOD Gameserver
###########################################################
FROM cm2network/steamcmd:root

ENV STEAMAPPID 4020
ENV STEAMAPPDIR /home/steam/gmod

ARG SRCDS_TOKEN
# Run Steamcmd and install GMOD
# Create autoupdate config - TODO: fix this
# Remove packages and tidy up
RUN set -x \
  && dpkg --add-architecture i386 \
  && apt-get update \
  && apt-get install -y --no-install-recommends --no-install-suggests \
  wget=1.20.1-1.1 \
  ca-certificates=20190110 \
  lib32z1=1:1.2.11.dfsg-1 \
  libncurses5:i386=6.1+20181013-2+deb10u2 \
  libbz2-1.0:i386=1.0.6-9.2~deb10u1 \
  lib32gcc1=1:8.3.0-6 \
  lib32stdc++6=8.3.0-6 \
  libtinfo5:i386=6.1+20181013-2+deb10u2 \
  libcurl3-gnutls:i386=7.64.0-4 \
  && su steam -c \
  "${STEAMCMDDIR}/steamcmd.sh \
  +login anonymous \
  +force_install_dir ${STEAMAPPDIR} \
  +app_update ${STEAMAPPID} validate \
  +quit \
  && { \
  echo '@ShutdownOnFailedCommand 1'; \
  echo '@NoPromptForPassword 1'; \
  echo 'login anonymous'; \
  echo 'force_install_dir ${STEAMAPPDIR}'; \
  echo 'app_update ${STEAMAPPID}'; \
  echo 'quit'; \
  } > ${STEAMAPPDIR}/gmod_update.txt \
  " \
  && apt-get remove --purge -y \
  wget \
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/*

ENV SRCDS_FPSMAX=300 \
  SRCDS_PORT=27015 \
  SRCDS_MAXPLAYERS=16 \
  SRCDS_TOKEN=${SRCDS_TOKEN} \
  SRCDS_RCONPW="changeme" \
  SRCDS_PW="changeme" \
  HOSTNAME="Powerd by agones™" \
  SRCDS_STARTMAP="gm_flatgrass"

# install curl for agones sdk interaction 
RUN apt-get update && apt-get install curl -y

ADD start.sh $STEAMAPPDIR
RUN chmod +x $STEAMAPPDIR/start.sh

USER steam
VOLUME $STEAMAPPDIR
WORKDIR $STEAMAPPDIR


ENTRYPOINT ["./start.sh"]

# Does agones need this?
EXPOSE 27015/tcp 27015/udp