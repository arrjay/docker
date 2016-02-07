#!/bin/bash

version=$(date +%s)

DNAME="arrjay/cc"

# you might want to change these?
MOCKCFGS="mockcfgs"
DEVTAR="devs.tar"
MOCK_CACHEDIR="/var/cache/mock"

# you probably won't want to change this.
CONFTAR="conf.tar"

# check for binaries
which mock &> /dev/null
res=$?

# reset umask
umask 0022

if [ $res != 0 ] ; then
  printf 'missing mock\n' 1>&2
  exit 2
fi

# check for user group membership
id -nG | grep -qw 'mock'
res=$?

if [ $res != 0 ] ; then
  printf 'user probably cannot run mock\n' 1>&2
  exit 2
fi

# check for device file archive
if [ ! -f "${DEVTAR}" ] ; then
  printf 'missing the /dev tar archive (run sudo mkdev.sh)\n' 1>&2
  exit 2
fi

# check for mock config dir
if [ ! -d "${MOCKCFGS}" ] ; then
  printf 'there is no %s directory\n' "${MOCKCFGS}" 1>&2
  exit 2
fi

# create config tar
scratch=$(mktemp -d --tmpdir $(basename $0).XXXXXX)
mkdir -p             "${scratch}"/etc/sysconfig
cp       yum.conf    "${scratch}"/etc/yum.conf
cp       startup.sh  "${scratch}"/startup
mkdir -p --mode=0755 "${scratch}"/var/cache/yum
mkdir -p --mode=0755 "${scratch}"/var/cache/ldconfig
printf 'NETWORKING=yes\nHOSTNAME=localhost.localdomain\n' > "${scratch}"/etc/sysconfig/network
printf '127.0.0.1   localhost localhost.localdomain\n'    > "${scratch}"/etc/hosts
tar --numeric-owner --group=0 --owner=0 -c -C "${scratch}" --files-from=- -f "${CONFTAR}" << EOA
./etc/yum.conf
./etc/hosts
./etc/sysconfig/network
./var/cache/yum
./var/cache/ldconfig
./startup
EOA

# use this for rpmdb extraction
rpmdbfiles=$(mktemp --tmpdir $(basename $0).XXXXXX)
cat << EOA > "${rpmdbfiles}"
./var/lib/rpm/Packages
./var/lib/rpm/Name
./var/lib/rpm/Basenames
./var/lib/rpm/Group
./var/lib/rpm/Requirename
./var/lib/rpm/Providename
./var/lib/rpm/Conflictname
./var/lib/rpm/Obsoletename
./var/lib/rpm/Triggername
./var/lib/rpm/Dirnames
./var/lib/rpm/Installtid
./var/lib/rpm/Sigmd5
./var/lib/rpm/Sha1header
EOA

# have mock make a root...
for c in "${MOCKCFGS}"/* ; do
  printf 'building image for %s\n' "${c}" 1>&2
  r=$(basename "${c}" .cfg)
  mock --configdir "${MOCKCFGS}" -r "${r}" --init
  cp "${MOCK_CACHEDIR}"/"${r}"/root_cache/cache.tar "${r}".tar
  # tar abuse!
  rpmdbdir=$(mktemp -d --tmpdir $(basename $0).XXXXXX)
  # first, pry the rpmdb out.
  tar -C "${rpmdbdir}" --extract --file="${r}".tar --files-from="${rpmdbfiles}"
  # conver db files to dump files
  for x in "${rpmdbdir}"/var/lib/rpm/* ; do
    /usr/lib/rpm/rpmdb_dump "${x}" > "${x}.dump"
    rm "${x}"
  done
  cat "${rpmdbfiles}" | awk '{printf "%s.dump\n",$0}' | tar --numeric-owner --group=0 --owner=0 -C "${rpmdbdir}" --create --file="${r}"-rpmdb.tar --files-from=-
  tar --delete --file="${r}".tar --files-from=- << EOA
./usr/lib/locale
./usr/share/locale
./lib/gconv
./lib64/gconv
./bin/localedef
./sbin/build-locale-archive
./usr/share/man
./usr/share/doc
./usr/share/info
./usr/share/gnome/help
./usr/share/cracklib
./usr/share/i18n
./var/cache/yum
./sbin/sln
./var/cache/ldconfig
./etc/ld.so.cache
./etc/sysconfig/network
./etc/hosts
./etc/hosts.rpmnew
./etc/yum.conf
./etc/yum.conf.rpmnew
./etc/yum/yum.conf
./builddir
$(cat "${rpmdbfiles}")
EOA

  # bring it all together
  tar --concatenate --file="${r}".tar "${DEVTAR}"
  tar --concatenate --file="${r}".tar "${CONFTAR}"
  tar --concatenate --file="${r}".tar "${r}"-rpmdb.tar

  # feed to docker
  docker import "${r}".tar "${DNAME}":"pre-${r}-${version}"

  # kick docker
  docker run -i --name "${r}-${version}" -t "${DNAME}":"pre-${r}-${version}" /startup

  # export that as a new image
  docker export "${r}-${version}" | docker import - "${DNAME}":"${r}-${version}"
done

