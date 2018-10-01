#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source /etc/fks/config

if [ $# -le 3 ]; then
    echo "Usage: fks-initFOLTempl.sh <year> <name in czech incl. diacritics\"\">"
    exit -1
fi

ls problems &> /dev/null
if [ $? -ne "0" ]; then
    echo "Run in repository 'fykos-ulohy' (no subdir problems)."
fi

year=$1
name=$2
fname=`iconv -f utf8 -t ascii//TRANSLIT <<< $name | 
        sed "s/ /_/g" | 
        tr '[:upper:]' '[:lower:]' |
        sed "s/[.,;:?!<> \/ \\ \" \' ( )]//g"`

# validate input
if [[ !($year =~ ^[0-9]+$) ]]; then
    echo "Invalid year: "$year
    exit -1
fi

# echo input params
echo "Creating problem:"
echo "  Year:  "$year 
echo "  Name:  "$name
echo "  Fname: "$fname
echo -n "Do you want to create template [Y/n]? "
read answer
if [ $answer == "Y" ];then
    echo "Creating problem file."
    id=`ls "in/series/R"$year"-"*"-"*".tex" 2>/dev/null | wc -l`
    fname="in/series/R"$year"-"$id"-"$fname".tex"
    cp $TEMPLATE_PATH/problem-FOLtempl.tex $fname
    sed -i "s/YY/"$year"/g" $fname
    sed -i "s/probname{/probname{$name/g" $fname
    echo "Problem file created."
    exit 0
fi
exit -2

