#!/bin/bash

if [ "$2x" = "x" ] ; then
	echo "Usage: $0 problemsdir statsfile"
	exit 1
fi

PROBLEMS=$1
STATSFILE=$2

sed -i 's/\r//' $STATSFILE
IFS=";"
cat $STATSFILE | while read batch problem max avg people ; do
	[ "x$problem" = "x" ] && continue
	FILE="${PROBLEMS}/problem$batch-$problem.tex"
	[ -f "$FILE" ] || continue
	
	sed -i 's/^%\\probsolvers/\\probsolvers/' $FILE
	sed -i 's/^\\probsolvers.*$/\\probsolvers{'$people'}/' $FILE
	sed -i 's/^%\\probavg/\\probavg/' $FILE
	sed -i 's/^\\probavg.*$/\\probavg{'$avg'}/' $FILE
done
