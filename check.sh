#!/bin/bash

BASE=arrjay/cc
IMAGES="c7-latest"

for image in $IMAGES ; do
  docker run --rm=true ${BASE}:$image yum check-update
  if [ $? -ne 0 ] ; then
    ./${image}.sh
  fi
done
