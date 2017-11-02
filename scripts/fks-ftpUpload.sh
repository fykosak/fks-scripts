#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source /usr/local/share/fks/semyr
source /etc/fks/config

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

for files in "$@" ; do
	file=$(basename $files)
	semyr $files

	case $file in
		reseni?-?.pdf)
			sfile="reseni/$(echo -n ${file:0:-5}${table[${file:8:1}]}.pdf)"
		;;
		serie?.pdf)
			sfile="$file"
		;;
		leaflet?.pdf)
			sfile="leaflet/$file"
		;;
		zadani?.pdf)
			sfile="serie${file:6:1}.pdf"
		;;
		serial?.pdf)
			sfile="serial/$file"
		;;
		rocenka??.pdf)
			sfile="../rocenky/$file"
		;;
		*)
			continue
	esac
#	echo "scp "$files $user"@"$server":"$path"/"$sfile
	scp $files $user@$server:$path/$sfile
	ssh $user@$server chown $user:fykos $path/$sfile
	ssh $user@$server chmod 664 $path/$sfile
done;
