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
cp "$TEMPLATE_PATH/year/Makefile.inc" Makefile.inc

# create dependency Makefile part
MAKEFILE="problems/Makefile.inc"

cat >$MAKEFILE <<END
# Makefile part for problems dependent images
# Need to define variables:	PD	problems dir
#				GD	graphics dir (for problems)

END

echo -n ".PHONY: " >>$MAKEFILE
for B in $(seq 1 $2); do
	echo "\\" >> $MAKEFILE
	for P in $(seq 1 $1); do
		echo -n "problem$B-$P " >>$MAKEFILE
	done
done
echo >>$MAKEFILE
for B in $(seq 1 $2); do
	echo  >> $MAKEFILE
	for P in $(seq 1 $1); do
		echo "problem$B-$P: \$(PD)/problem$B-$P.tex" >>$MAKEFILE
	done
done

