#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/config

TEMPLATE_PATH=$(dirname $0)/../templates
PROBLEMS_DIR=problems
PROB_COUNT=8

# Initializes a directory for a leaflet in current directory

if [ "$1" = "" ] ; then
	echo "Usage: $0 <batchno>"
	exit 1
fi

if [ -d "leaflet$1" ] ; then
	echo "Leaflet no. $1 already exists."
	exit 1
fi


# copy empty leaflet structure
cp -r "$TEMPLATE_PATH/year/leaflet" "./leaflet$1"

# rename batch dependend values
cd "./leaflet$1"
rename "s/(.*)B.tex\$/\${1}$1.tex/" *.tex

PREV=$(($1-1))
sed -i "s/BATCHNO=B$/BATCHNO=$1/" Makefile
sed -i "s/SOLVEDBATCHNO=BB/SOLVEDBATCHNO=$PREV/" Makefile
sed -i "s/\\\\setcounter{batch}{B}/\\\\setcounter{batch}{$1}/" leaflet$1.tex
sed -i "s/\\\\setcounter{year}{Y}/\\\\setcounter{year}{$rocnik}/" leaflet$1.tex


