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

ENV SRCDS_FPSMAX=300
ENV SRCDS_PORT=27015
ENV SRCDS_MAXPLAYERS=16
ENV SRCDS_TOKEN=${SRCDS_TOKEN}
ENV SRCDS_RCONPW='changeme'
ENV SRCDS_PW='changeme'
ENV HOSTNAME='Powerd by agones™'
ENV SRCDS_STARTMAP='gm_flatgrass'

# install git and go so we can build dsg-wrapper
RUN apt-get update && apt-get install git golang-go curl -y

# setup the wrapper util
WORKDIR /tmp
RUN git clone https://github.com/Hacksore/dsg-wrapper.git
RUN cd /tmp/dsg-wrapper && go build
RUN cp /tmp/dsg-wrapper/dsg-wrapper $STEAMAPPDIR/dsg-wrapper
RUN chmod +x $STEAMAPPDIR/dsg-wrapper

# add start script
ADD start.sh $STEAMAPPDIR
RUN chmod +x $STEAMAPPDIR/start.sh

# add code for gamemodes
RUN git clone -b agones-support https://github.com/Hacksore/minigames_v2.git $STEAMAPPDIR/gamemodes

# add config
ADD server.cfg $STEAMAPPDIR/garrysmod/cfg/server.cfg

# make game user own it all
RUN chown -R steam:steam $STEAMAPPDIR

VOLUME $STEAMAPPDIR
WORKDIR $STEAMAPPDIR

USER steam

ENTRYPOINT $STEAMAPPDIR/dsg-wrapper -i $STEAMAPPDIR/start.sh -s "VAC secure mode"