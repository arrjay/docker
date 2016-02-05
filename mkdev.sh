#!/bin/bash

target=$(mktemp -d --tmpdir $(basename $0).XXXXXX)

mkdir -m 755 "${target}"/dev
mknod -m 600 "${target}"/dev/console c 5 1
mknod -m 600 "${target}"/dev/initctl p
mknod -m 666 "${target}"/dev/full    c 1 7
mknod -m 666 "${target}"/dev/null    c 1 3
mknod -m 666 "${target}"/dev/ptmx    c 5 2
mknod -m 666 "${target}"/dev/random  c 1 8
mknod -m 666 "${target}"/dev/tty     c 5 0
mknod -m 666 "${target}"/dev/tty0    c 4 0
mknod -m 666 "${target}"/dev/urandom c 1 9
mknod -m 666 "${target}"/dev/zero    c 1 5

tar --numeric-owner -c -C "${target}" ./dev -f devs.tar
