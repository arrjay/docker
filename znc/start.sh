#!/bin/bash

# start znc using su - "-d /znc -f" are args to znc
/usr/bin/su --session-command /usr/bin/znc "-d /znc -f" znc
