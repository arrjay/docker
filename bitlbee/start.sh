#!/bin/bash

# replace 'bitlbee.docker' with instance name
if [ ! -z "${HOSTNAME}" ] ; then
  sed -i -e s/bitlbee.docker/${HOSTNAME}/ /etc/bitlbee/bitlbee.conf
fi

# start bitlbee
/usr/sbin/bitlbee -nv
