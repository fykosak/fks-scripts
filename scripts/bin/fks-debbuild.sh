#!/bin/bash

function print_help {
	echo "Usage: $0 [-g <git dir>][-r <refspec>][-b <builddir>]"
	echo "    Will create DEB binary package from git repository."
	echo "    Repository must contain file deb.info which defines PKG_NAME and PREFIX variables."
	echo
	echo "Parameters:"
	echo "    -g <git dir>    [$GITDIR]"
	echo "    -r <refspec>    [$REFSPEC]"
	echo "    -b <builddir>   [$GITDIR]"
	exit 1
}

function render_template {
	version=`git describe $1 --tags`
	for f in "$WORKDIR/DEBIAN"/*.tpl ; do
		r=${f%.tpl}

		sed "s/%version%/$version/" <$f |\
		sed "s#%prefix%#$PREFIX#" >$r
		[ -x $f ] && chmod 755 $r
	done
	[ -f "$WORKDIR$PREFIX/deb.info" ] && rm "$WORKDIR$PREFIX/deb.info"
}

function package_name {
	set -o pipefail
	git show $1:DEBIAN/control.tpl | sed -n "/^Package:/{s/^Package: *\(.*\)/\1/;p}" ||	die "Cannot find DEBIAN/control.tpl"
}

function load_info {
	set -o pipefail
	file=`mktemp`
	git show $1:deb.info>$file 2>/dev/null
	if [ $? -eq 0 ] ; then
		. $file
		rm $file
	else
		METAPACKAGE=1
	fi
}

function die {
	echo "$@" 1>&2
	exit 1
}

GITDIR=$PWD
REFSPEC=master
BUILDDIR=$PWD

while [ $# -ge 1 ] ; do
	case "$1" in
		-g)
			GITDIR="$2"
			shift
			;;
		-r)
			REFSPEC="$2"
			shift
			;;
		-b)
			BUILDDIR="$2"
			shift
			;;
		-h|--help)
			print_help
			exit 0
			;;
	esac
	shift
done

[ -d "$GITDIR/DEBIAN" ] || die "Directory DEBIAN not present in the repository."


export GIT_DIR="$GITDIR/.git"
PKG_NAME=`package_name $REFSPEC`

load_info
WORKDIR="/tmp/$PKG_NAME"

rm -rf $WORKDIR
mkdir $WORKDIR

# everything goes into the same directory
if [ "x$PREFIX" != "x" ] ; then
	paths=`git ls-tree --name-only $REFSPEC | sed "s#DEBIAN##"`

	mkdir -p "$WORKDIR$PREFIX"
	git archive --prefix="${PREFIX#/}/" "$REFSPEC" $paths | tar -x -C "$WORKDIR"
elif [ "x$METAPACKAGE" = "x" ] ; then # special directories for predefined groups
	for type in bin share conf ; do
		prefname="PREFIX_$type"
		prefix=${!prefname}
		pathname="PATHS_$type"
		paths=${!pathname}
	
		mkdir -p "$WORKDIR$prefix"
		git archive --prefix="${prefix#/}/" "$REFSPEC" $paths | tar -x -C "$WORKDIR"
	done
fi

git archive "$REFSPEC" DEBIAN | tar -x -C "$WORKDIR"

render_template "$REFSPEC"

fakeroot dpkg-deb -Zgzip --build "$WORKDIR" "$BUILDDIR"

rm -rf "$WORKDIR"
unset GIT_DIR
