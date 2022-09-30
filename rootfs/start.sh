#!/bin/bash
set -x

ARGS="$@"

if $(echo "$ARGS" | grep -q 'participants=auto'); then
    # set number of participants to num_cpus / 2
    NUM_PARTICIPANTS=$[ $(nproc) / 2]
    ARGS=$(echo $ARGS | sed "s/--participants=auto/--participants=$NUM_PARTICIPANTS/")
fi

# random delay so that client are not started at a same time
if $(echo "$ARGS" | grep -q 'maxdelay='); then
    MAXDELAY_ARG=$(echo "$ARGS" | grep -o 'maxdelay=[0-9]*')
    MAXDELAY=${MAXDELAY_ARG#maxdelay=}
    RANDELAY=$[($RANDOM % $MAXDELAY)]
    echo "delay $RANDELAY before starting ..."
    sleep $RANDELAY

    # set number of participants to num_cpus / 2
    NUM_PARTICIPANTS=$[ $(nproc) / 2]
    ARGS=$(echo $ARGS | sed "s/--maxdelay=[^ ]*//")
fi

# start selenium grid in background
./opt/bin/entry_point.sh &
sleep 2

cd /jitsi-meet-torture
./scripts/ag-test.sh $ARGS
