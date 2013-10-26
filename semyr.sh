

function semyr {
	filefull=`pwd`/$1
	IFS='/' read -a array <<< "$filefull"
	# delka retezce
	for ((i=0; ; i++)) do
		if [ "${array[$i]}" = "" ]; then
			end=$i
			break
		fi
	done
# prohledani odzadu
	for ((i=$end; ; i--)) do
		lgt=`expr length "${array[$i]}"`
		fks=`expr match  "${array[$i]}" 'fykos'`
		vfk=`expr match  "${array[$i]}" 'vyfuk'`
		if [ "$lgt" -ge "6" ] ; then 
			if [ "$fks" -ne "0" ]; then 
				rocnik=${array[$i]:5}
				path=$pathFYKOS$rocnik
				seminar="fykos"
				break
			fi
			if [ "$vfk" -ne "0" ] ; then 
				rocnik=${array[$i]:5}
				path=$pathVYFUK$rocnik
				seminar="vyfuk"
				break
			fi
		fi
	done

}
