#!/bin/bash

rocnik=25
user=***REMOVED***
server=utf.troja.mff.cuni.cz
path=/www/fykos/rocnik${rocnik}/reseni



if [ "x$1" = "x" ] ; then
	echo "Usage: $(basename $0) [FILEs] ..."
	exit 1
fi

# table for transforming problem names
table[1]=1
table[2]=2
table[3]=3
table[4]=4
table[5]=8
table[6]=5
table[7]=6
table[8]=7
# $1 source file, return via echo
function transformName {
	case $1 in
		reseni?-?.pdf)
			echo -n ${1:0:-5}${table[${1:8:1}]}.pdf
		;;
		*)
			return 1
		;;
	esac
	return 0
}

put=''
for file in "$@" ; do
	put="${put}put $file $(transformName $file)"
	put="$put
"
done;


cmd="$user
cd $path
${put}quit"

#echo "$cmd"

echo "$cmd" | ftp utf.troja.mff.cuni.cz
