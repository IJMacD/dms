#!/bin/bash

if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <container-name> [<timeout>] [<interval>]"
    echo "    <timeout> is in date(1) -d relative format. default: '-1hour'"
    echo "    <interval> is seconds between checks. default: '60'"
    exit 1
fi

CONTAINER_NAME=$1
TIMEOUT=${2:-"-1hour"}
INTERVAL=${3:-"60"}
FMT="+%FT%T"

while true; do
    LOG_TIME=$(docker logs -n 1 --timestamps $CONTAINER_NAME 2>&1 | cut -d' ' -f1)

    if [[ $(date $FMT -d $LOG_TIME) < $(date $FMT -d '-1hour') ]]; then
        echo "No output from $CONTAINER_NAME since $LOG_TIME. Restarting container"
        docker restart $CONTAINER_NAME
    else
        echo "$CONTAINER_NAME is alive"
    fi

    sleep $INTERVAL
done