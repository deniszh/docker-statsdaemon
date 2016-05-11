#!/bin/sh
# build statsdaemon from source, to be added to the docker image
set -e
STATSDAEMON_SRC=${STATSDAEMON_SRC:-../statsdaemon}

ORIGDIR=$(pwd)

cd $STATSDAEMON_SRC

export GOOS=linux
export GOARCH=amd64
export CGO_ENABLED=0
go build -o $ORIGDIR/statsdaemon -ldflags="-s -w"
