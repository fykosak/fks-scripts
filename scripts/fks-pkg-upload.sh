#!/bin/bash

source /etc/fks/config

DIST=fks
SECTION=main # ?? it's required

if [ "x$1" = "x" -o "$1" = "-h" ] ; then
	echo "Usage: $0 [-d dist] deb-file(s) ..."
	echo "   Default dist is '$DIST'."
	exit 1
fi


if [ "$1" = "-d" ] ; then
	DIST=$2
	shift; shift
fi

# upload
scp $@ $pkg_user@$pkg_server:/tmp/

# add to repo
for file in "$@" ; do
	ssh $pkg_user@$pkg_server reprepro -S $SECTION -b $pkg_path/$DIST includedeb $DIST /tmp/`basename $file`
done

# sign the repo
scp $pkg_user@$pkg_server:$pkg_path/$DIST/dists/$DIST/Release /tmp
gpg -o /tmp/Release.gpg -ba /tmp/Release 
scp /tmp/Release.gpg $pkg_user@$pkg_server:$pkg_path/$DIST/dists/$DIST/Release.gpg
rm -f /tmp/Release /tmp/Release.gpg

ssh $pkg_user@$pkg_server rm "/tmp/*.deb"
