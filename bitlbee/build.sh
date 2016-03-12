#!/bin/bash

myver=$(git log -1 --format=%h)

# create bitlbee image with a tag of the current repo, and the date.
docker build -t arrjay/cc:bitlbee-c7-BETA-${myver} .

# get the date the image has back in a rather ugly fashion
genesis=$(docker run --rm=true --entrypoint=cat arrjay/cc:bitlbee-c7-BETA-${myver} /motd.txt|awk -F'(' '{if ($2 != "") {print $2}}'|sed 's/)//')

# tests would go here...

# and tag _that_
docker tag arrjay/cc:bitlbee-c7-BETA-${myver} arrjay/cc:bitlbee-c7-${myver}-${genesis}

# remove the beta image
docker rmi arrjay/cc:bitlbee-c7-BETA-${myver}
