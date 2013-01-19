#!/bin/bash
if [ "x$3" = "x" ] ; then
	echo "Usage: $0 <URL> <request-file> <response-file>"
	echo "       Response is written to <response-file>, can be '-' for stdout."
	exit 1
fi

DEBUG="--server-response --no-check-certificate"
wget --post-file="$2" --header="Content-Type: text/xml" --header="SOAPAction: \"GetStats\"" $DEBUG "$1" -O "$3"
