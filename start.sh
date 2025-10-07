#!/bin/sh
set -eux

# default settings
MAX_PLAYERS=${MAX_PLAYERS:-8}
DAYS_BEFORE_BLIZZARD=${DAYS_BEFORE_BLIZZARD:-3}
DAY_MINUTES=${DAY_MINUTES:-9}
PREDATOR_DAMAGE=${PREDATOR_DAMAGE:-1}
COLD_INTENSITY=${COLD_INTENSITY:-1}
HUNGER_RATE=${HUNGER_RATE:-1}
COAL_BURN_RATE=${COAL_BURN_RATE:-1}
THRALLS=${THRALLS:-2}

MAP=${MAP:-Approach_Persistent}

# the server exits after a round, so just keep rerunning it.
while true; do
  ./DreadHunger/Binaries/Linux/DreadHungerServer-Linux-Shipping DreadHunger \
    "$MAP?maxplayers=$MAX_PLAYERS?daysbeforeblizzard=$DAYS_BEFORE_BLIZZARD?dayminutes=$DAY_MINUTES?predatordamage=$PREDATOR_DAMAGE?coldintensity=$COLD_INTENSITY?hungerrate=$HUNGER_RATE?coalburnrate=$COAL_BURN_RATE?thralls=$THRALLS" \
    "$@"
done
