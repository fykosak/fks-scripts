#!/bin/bash
if [ "x$2" = "x" ] ; then
	echo "Usage: $0 <request-file> <response-file> [<username> <password>]"
	echo "       Response is written to <response-file>, can be '-' for stdout."
	echo "       When <username> and <password> are set, they will be used as credentials"
	echo "       in a wget request."
	exit 1
fi

CREDENTIALS=""
if [ -n "$3" -a -n "$4" ] ; then
	USERNAME=`echo -n "$3" | base64 -d`
	PASSWORD=`echo -n "$4" | base64 -d`
	CREDENTIALS="--user=$USERNAME --password=$PASSWORD"
fi

URL=$(cat "$1" | tr -d '\n')
DEBUG="--server-response --no-check-certificate"
 wget $CREDENTIALS --header="Content-Type: application/json" $DEBUG "$URL" -O "$2"
[ $? = 0 ] || rm "$2"

true # when the condition above fails, still have exit code 0
