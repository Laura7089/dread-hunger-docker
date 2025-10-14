FROM steamcmd/steamcmd AS steambuild
# MAINTAINER Laura Demkowicz-Duffy

ARG UID=999
ARG GID=999

ENV CONFIG_LOC="/config"
ENV INSTALL_LOC="/dreadhunger"
ENV HOME=${INSTALL_LOC}
ENV DEBIAN_FRONTEND="noninteractive"

USER root

RUN apt update && \
    # Install libsdl, used by steamcmd
    apt install -y --no-install-recommends libsdl2-2.0-0

# Setup directory structure and user permissions
RUN groupadd -g $GID dreadhunger && \
    useradd -m -s /bin/false -u $UID -g $GID dreadhunger && \
    mkdir -p $CONFIG_LOC && \
    chown -R dreadhunger:dreadhunger $CONFIG_LOC

# instead of installing with steamcmd, we copy server files from the local filesystem.
# because of the way that docker build contexts work, the user must either copy or link
# the server installation into the local directory.
# TODO: put this in the readme
COPY --chown=dreadhunger ./LinuxServer "$INSTALL_LOC"

USER dreadhunger

# dread hunger can no longer be installed with steamcmd, so only install the steam library
# TODO: do we even need that, or can we ditch steam altogether?
ARG APPID=1418630
ARG STEAM_BETA=""
RUN steamcmd \
        +force_install_dir "$INSTALL_LOC" \
        +login anonymous \
        +app_update 1007 validate \
        +quit

COPY --chown=dreadhunger --chmod=0755 ./start.sh "$INSTALL_LOC/start.sh"

# the game seems to use this
ENV UE4_PROJECT_ROOT=${INSTALL_LOC}

# I/O
VOLUME $CONFIG_LOC
EXPOSE 7777/udp

USER dreadhunger
WORKDIR $INSTALL_LOC
ENTRYPOINT ["./start.sh"]
