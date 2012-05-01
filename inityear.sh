#!/bin/bash

TEMPLATE_PATH=$(dirname $0)/../templates
PROBLEMS_DIR=problems

# Initializes a year structure in current directory

if [ "$1" = "" ] ; then
	echo "Usage: inityear <prob count> <batch count>"
	exit 1
fi


# create empty year structure
mkdir problems
cp -r "$TEMPLATE_PATH/year/problems/graphics" "./problems/graphics"
cp  "$TEMPLATE_PATH/year/problems/web.tex" "./problems/web.tex"
cp "$TEMPLATE_PATH/year/Makefile.inc" Makefile.inc
cp "$TEMPLATE_PATH/year/Makefile" Makefile

# create dependency Makefile part
MAKEFILE="problems/Makefile.inc"

cat >$MAKEFILE <<END
# Makefile part for problems dependent images
# Problem TeX file must be first dependecy in order building process worked
# correctly

END

echo >>$MAKEFILE
for B in $(seq 1 $2); do
	echo  >> $MAKEFILE
	for P in $(seq 1 $1); do
		echo "problem${B}_$P= problem$B-$P.tex" >>$MAKEFILE
	done
done

