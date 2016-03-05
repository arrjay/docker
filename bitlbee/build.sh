#!/bin/bash

myver=$(git log -1 --format=%h)

# create bitlbee image with a tag of the current repo, and the date.
docker build -t bitlbee-c7-${myver}-$(date +%s) .
