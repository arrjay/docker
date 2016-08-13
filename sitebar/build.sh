#!/bin/bash

myver=$(git log -1 --format=%h)

# create znc image with a tag of the current repo, and the date.
docker build -t arrjay/cc:sitebar-c7-${myver}-$(date +%s) .

# tests would go here...

