#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source /usr/local/share/fks/semyr
source /etc/fks/config

PROBLEMS_DIR=problems

#setup year & seminar
semyr ""

# solved batch
if   [ "$fks" -ne "0" ]; then
	PREV=$(($2-$fksshift))
	PROB_COUNT=8
	PROBLEMSLIST="1 2 3 4 5 6 7 8"
	RESULTSLIST="1 2 3 4"
	echo "FYKOS "$rocnik
fi
if [ "$vfk" -ne "0" ]; then
	PREV=$(($2-$vfkshift))
	if [ "$2" = "7" ]; then
		PREV="5 6"
	fi
	PROB_COUNT=6
	PROBLEMSLIST="1 2 3 4 5 6"
	RESULTSLIST="6 7 8 9"
	echo "VYFUK "$rocnik
fi


# Initializes a directory for a leaflet or batch in current directory

# batch
if [ "$1" = "b" ] ; then
	if [ "$2" = "" ] ; then
		echo "Usage: $0 b <batchno> [<probcount>]"
		exit 1
	fi
	
	if [ -d "batch$2" ] ; then
		echo "Batch no. $2 already exists."
		exit 1
	fi

	if [ "$3" != "" ] ; then
		PROB_COUNT=$3
	fi
	dirpath=batch
# leaflet
elif [ "$1" = "l" ] ; then
	if [ "$2" = "" ] ; then
		echo "Usage: $0 l <batchno>"
		exit 1
	fi

	if [ -d "leaflet$2" ] ; then
		echo "Leaflet no. $2 already exists."
		exit 1
	fi
	dirpath=leaflet
# help
else
	echo "Usage: $0 l|b <batchno> [<probcount>]"
	echo "           b   initializes a batch"
	echo "           l   initializes a leaflet"
	exit 1
fi

############################################################
# copy empty leaflet/batch structure
cp -r "$TEMPLATE_PATH/year/$dirpath" $dirpath$2
dirpath=$dirpath$2
cd $dirpath
if [ $seminar = "fykos" ];then
	rm *.vyfuk
else
	rm *.fykos
fi

# cut .fykos|.vyfuk
for file in *.$seminar ; do
	mv $file ${file%.$seminar}
done

# rename batch dependend values
for file in *.tex; do
	IFS='B' read -a array <<< "$file"
	if [ "${array[1]}" != "" ]; then
# update data in files
		sed -i "s/\\\\setcounter{year}{Y}/\\\\setcounter{year}{$rocnik}/" $file
		sed -i "s/\\\\setcounter{batch}{B}/\\\\setcounter{batch}{$2}/"    $file
		sed -i "s/\\\\setcounter{solvedbatch}{AB}/\\\\setcounter{solvedbatch}{$PREV}/"    $file
		sed -i "s/vysledkyB/vysledky$PREV/"                               $file
		sed -i "s/SEM/$seminar/"                                          $file
		mv $file ${array[0]}$2${array[1]:0:4}
	fi
done


# update data in Makefile
sed -i "s/\\\\setcounter{year}{Y}/\\\\setcounter{year}{$rocnik}/" Makefile
sed -i "s/BATCHNO=B$/BATCHNO=$2/"                                 Makefile
sed -i "s/SOLVEDBATCHNO=AB/SOLVEDBATCHNO=$PREV/"                  Makefile
sed -i "s/problemcount{PB}/problemcount{$PROB_COUNT}/"            Makefile
sed -i "s/problemslist/$PROBLEMSLIST/"                            Makefile
sed -i "s/resultslist/$RESULTSLIST/"                              Makefile
sed -i "s/SEM/$seminar/"                                          Makefile

# create problems
if [ "$1" = "b" ]; then
	cd "../$PROBLEMS_DIR"
	for P in $(seq 1 $PROB_COUNT); do
		FILENAME="problem$2-$P.tex"
		cp "$TEMPLATE_PATH/year/problems/problemB-P.tex" "$FILENAME"
		sed -i "s/\\\\probbatch{B}/\\\\probbatch{$2}/;s/\\\\probno{P}/\\\\probno{$P}/" $FILENAME
	done
fi

cd ../

