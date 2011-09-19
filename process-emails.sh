#!/bin/bash

INFILE=-
OUTFILE=~/texmf/tex/latex/fykosx/fksemails.tex

if [ "$1" = "" ] ; then
	echo "Usage: process-emails [csvfile [outputfile]]"
	echo "       Default: $INFILE $OUTFILE"
	exit 1
fi

if [ "$2" != "" ] ; then
	INFILE=$1
	OUTFILE=$2
else 
	INFILE=$2
fi

cat $INFILE | sed -E 's/(.*);(.*);(.*)/\\newsignature{\1}{\2}{\3}/' > $OUTFILE


