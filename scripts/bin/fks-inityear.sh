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
mkdir -p pdf
cp -rT "$TEMPLATE_PATH/year/problems/graphics" "./problems/graphics"
cp "$TEMPLATE_PATH/year/Deadline_xml.inc" .
cp "$TEMPLATE_PATH/year/Makefile.inc" .
cp "$TEMPLATE_PATH/year/.gitignore.sample" ".gitignore"
cp "$TEMPLATE_PATH/year/.gitattributes.sample" ".gitattributes"
cp "$TEMPLATE_PATH/year/Makefile.conf.sample" .
cp "$TEMPLATE_PATH/year/Makefile" .
cp "$TEMPLATE_PATH/year/data/"* ./data

# keep files needed by seminar
if [ $seminar = "fykos" ];then
	mkdir -p results
	find . -name "*.vyfuk" -type f -delete
else
    mkdir -p todo
    cp -r "$TEMPLATE_PATH/year/todo/"* ./todo
	find . -name "*.fykos" -type f -delete
fi

# cut .fykos|.vyfuk
for file in $(find . -name "*.$seminar" -type f) ; do
	mv $file ${file%.$seminar}
done

#SOAP files parameters
for file in data/statsRequest.soap data/statsRequest.soap Makefile.inc; do
	sed -i "s/SEM/$seminar/" 	$file
	sed -i "s/YEAR/$rocnik/" 	$file
done

if [ $seminar = "fykos" ];then
	sed -i "s/SEMID/1/" data/signaturesRequest.soap
else
	sed -i "s/SEMID/2/" data/signaturesRequest.soap
fi

echo "Year initialized. Before commiting do not forget to modify contest specific information."
echo "This mostly applies to:"
echo "    - contest name in Makefile.conf.sample"
