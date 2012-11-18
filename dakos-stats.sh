#!/bin/bash

PROBLEMS=../problems
STATSFILE=$1

sed -i 's/\r//' $STATSFILE
IFS=";"
cat $STATSFILE | while read batch problem max avg people ; do
	[ "x$problem" = "x" ] && continue
	FILE="${PROBLEMS}/problem$batch-$problem.tex"
	
	sed -i 's/^%\\probsolvers/\\probsolvers/' $FILE
	sed -i 's/^\\probsolvers.*$/\\probsolvers{'$people'}/' $FILE
	sed -i 's/^%\\probavg/\\probavg/' $FILE
	sed -i 's/^\\probavg.*$/\\probavg{'$avg'}/' $FILE
done
