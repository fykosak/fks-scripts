#!/bin/bash

source /usr/share/fks/semyr
source /etc/fks/config

PROBLEMS_DIR=problems

#setup year & seminar
semyr ""

# Initializes a year structure in current directory

if [ "$1" = "" ] ; then
	echo "Usage: inityear <prob count> <batch count>"
	exit 1
fi


# create empty year structure
mkdir -p problems
mkdir -p data
mkdir -p todo
mkdir -p pdf
cp -rT "$TEMPLATE_PATH/year/problems/graphics" "./problems/graphics"
cp "$TEMPLATE_PATH/year/Deadline_xml.inc" .
cp "$TEMPLATE_PATH/year/Makefile.inc" .
cp "$TEMPLATE_PATH/year/.gitignore.sample" ".gitignore"
cp "$TEMPLATE_PATH/year/.gitattributes.sample" ".gitattributes"
cp "$TEMPLATE_PATH/year/Makefile.conf.sample" .
#cp "$TEMPLATE_PATH/year/Makefile.conf.sample" Makefile.conf
cp "$TEMPLATE_PATH/year/Makefile" .
cp "$TEMPLATE_PATH/year/data/"* ./data
cp -r "$TEMPLATE_PATH/year/pdf/"* ./pdf

# keep files needed by seminar
if [ $seminar = "fykos" ];then
	mkdir -p results
	find . -name "*.vyfuk" -type f -delete
else
    cp -r "$TEMPLATE_PATH/year/todo/"* ./todo
	find . -name "*.fykos" -type f -delete
fi

# cut .fykos|.vyfuk
for file in $(find . -name "*.$seminar" -type f) ; do
	mv $file ${file%.$seminar}
done

# create dependency Makefile part
MAKEFILE="problems/Makefile-manual.inc"

cat >$MAKEFILE <<END
# Makefile part for problems dependent images
# Problem TeX file must be first dependecy in order building process worked
# correctly

END

echo >>$MAKEFILE
for B in $(seq 1 $2); do
	echo  >> $MAKEFILE
	for P in $(seq 1 $1); do
		echo "problem${B}_$P= problem$B-$P.tex" >>$MAKEFILE
	done
done

#SOAP files parameters

for file in $(find . -name "*.soap" -type f) Makefile.inc; do
	sed -i "s/SEM/$seminar/" 	$file
	sed -i "s/YEAR/$rocnik/" 	$file
done



echo "Year initialized. Before commiting do not forget to modify contest specific information."
echo "This mostly applies to:"
echo "    - contest name in Makefile.conf.sample"


