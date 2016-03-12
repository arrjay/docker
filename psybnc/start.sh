#!/bin/bash

# switch to build directory
cd /usr/src/psybnc

# start psybnc with args
/usr/bin/psybnc $1

# die if no pid file
if [ ! -f psybnc.pid ] ; then exit 1 ; fi

# hang around for psybnc to die in 30 sec increments
while $(ps h -q $(cat psybnc.pid) -o comm > /dev/null) ; do
  sleep 30
done
