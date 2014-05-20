#!/bin/bash

source /etc/fks/config

PROBLEMS_DIR=problems

# Initializes a year structure in current directory

if [ "$1" = "" ] ; then
	echo "Usage: inityear <prob count> <batch count>"
	exit 1
fi


# create empty year structure
mkdir problems
mkdir results
mkdir data
cp -r "$TEMPLATE_PATH/year/problems/graphics" "./problems/graphics"
cp "$TEMPLATE_PATH/year/problems/web.tex" "./problems/"
cp "$TEMPLATE_PATH/year/Deadline.inc" .
cp "$TEMPLATE_PATH/year/Makefile.inc" .
cp "$TEMPLATE_PATH/year/.gitignore" .
cp "$TEMPLATE_PATH/year/Makefile.conf.sample" .
cp "$TEMPLATE_PATH/year/Makefile.conf.sample" Makefile.conf
cp "$TEMPLATE_PATH/year/Makefile" .
cp "$TEMPLATE_PATH/year/data/"* ./data

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

echo "Year initialized. Before commiting do not forget to modify contest specific information."
echo "This mostly applies to problem labels in SOAP requests(!)"

