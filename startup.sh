#!/bin/bash
set -x

dbload=/usr/bin/db_load

# bring RPM back online from export so it works in chroot.
cd /var/lib/rpm

for x in *.dump ; do
  cat "${x}" | /usr/lib/rpm/rpmdb_load $(basename "${x}" .dump)
  rm "${x}"
done

rpm --rebuilddb

yum clean all

# if we find ourselves, delete ourselves.
if [[ -s "$BASH_SOURCE" ]] && [[ -x "$BASH_SOURCE" ]]; then
        rm $(readlink -f "$BASH_SOURCE")
fi
