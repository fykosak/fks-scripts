#!/bin/bash

source /usr/local/share/fks/semyr.sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source /etc/fks/config


PROBLEMS_DIR=problems
PROB_COUNT=8

# Initializes a directory for new series in current directory

if [ "$1" = "" ] ; then
	echo "Usage: initbatch <batchno>[ <probcount>]"
	exit 1
fi

if [ -d "batch$1" ] ; then
	echo "Batch no. $1 already exists."
	exit 1
fi

if [ "$2" != "" ] ; then
	PROB_COUNT=$2
fi

# copy empty batch structure
cp -r "$TEMPLATE_PATH/year/batch" "./batch$1"

# rename batch dependend values
cd "./batch$1"
#rename "s/(.*)B.tex\$/\${1}$1.tex/" *.tex
mv batchB.tex batch$1.tex
mv serialB.tex serial$1.tex
mv uvodB.tex uvod$1.tex
mv problemsB.tex problems$1.tex

PREV=$(($1-1))
sed -i "s/BATCHNO=B/BATCHNO=$1/" Makefile
sed -i "s/DEADLINE\\[B\\]/DEADLINE[$1]/" Makefile
sed -i "s/DEADLINES\\[B\\]/DEADLINES[$1]/" Makefile
sed -i "s/SOLVEDBATCHNO=AB/SOLVEDBATCHNO=$PREV/" Makefile
sed -i "s/problemcount{PB}/problemcount{$PROB_COUNT}/" Makefile
sed -i "s/\\\\setcounter{year}{Y}/\\\\setcounter{year}{$rocnik}/" batch$1.tex
sed -i "s/\\\\setcounter{year}{Y}/\\\\setcounter{year}{$rocnik}/" problems$1.tex
sed -i "s/\\\\setcounter{year}{Y}/\\\\setcounter{year}{$rocnik}/" Makefile
sed -i "s/\\\\setcounter{batch}{B}/\\\\setcounter{batch}{$1}/" batch$1.tex
sed -i "s/\\\\setcounter{batch}{B}/\\\\setcounter{batch}{$1}/" problems$1.tex
sed -i "s/vysledkyB/vysledky$PREV/" batch$1.tex

# create problems
cd "../$PROBLEMS_DIR"

for P in $(seq 1 $PROB_COUNT); do
	FILENAME="problem$1-$P.tex"
	cp "../$TEMPLATE_PATH/year/problems/problemB-P.tex" "$FILENAME"
	sed -i "s/\\\\probbatch{B}/\\\\probbatch{$1}/;s/\\\\probno{P}/\\\\probno{$P}/" $FILENAME
done

cd ../
