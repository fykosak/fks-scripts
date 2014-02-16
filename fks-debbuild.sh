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

if [ ! -f "$GITDIR/deb.info" ] ; then
	echo "File deb.info not present in the repository."
	exit 1
fi

. "$GITDIR/deb.info"
WORKDIR="/tmp/$PKG_NAME"
export GIT_DIR="$GITDIR/.git"

function render_template {
	version=`git describe $1 --tags`
	for f in "$WORKDIR/DEBIAN"/*.tpl ; do
		r=${f%.tpl}

		sed "s/%version%/$version/" <$f |\
		sed "s#%prefix%#$PREFIX#" >$r
		[ -x $f ] && chmod 755 $r
	done
}

rm -rf $WORKDIR
mkdir $WORKDIR
mkdir -p "$WORKDIR$PREFIX"

#[ -f $GITDIR/.gitattributes ] && sed -i "1iDEBIAN export-ignore" $GITDIR/.gitattributes
#git archive --worktree-attributes --prefix="${PREFIX#/}/" "$REFSPEC" | tar -x -C "$WORKDIR"
paths=$(for p in `echo "$GITDIR"/* | sed "s#$GITDIR/DEBIAN##"` ; do basename $p ; done | xargs echo)

git archive --prefix="${PREFIX#/}/" "$REFSPEC" $paths | tar -x -C "$WORKDIR"
#[ -f $GITDIR/.gitattributes ] && git checkout "$REFSPEC" -- $GITDIR/.gitattributes

git archive "$REFSPEC" DEBIAN | tar -x -C "$WORKDIR"

render_template "$REFSPEC"


fakeroot dpkg-deb --build "$WORKDIR" "$BUILDDIR"

#rm -rf $WORKDIR
unset GIT_DIR
