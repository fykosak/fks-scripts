#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source /etc/fks/config

if [ $# -le 3 ]; then
    echo "Usage: fks-initTempl.sh <year> <batch> <probType:J|N|P|E|S> <name in czech incl. diacritics\"\">"
    exit -1
fi

ls problems &> /dev/null
if [ $? -ne "0" ]; then
    echo "Run in repository 'fykos-ulohy' (no subdir problems)."
fi

year=$1
batch=$2
ptype=$3
name=$4
fname=`iconv -f utf8 -t ascii//TRANSLIT <<< $name | 
        sed "s/ /_/g" | 
        tr '[:upper:]' '[:lower:]' |
        sed "s/[.,;:?!<> \/ \\ \" \' ( )]//g"`

# validate input
if [[ !($year =~ ^[0-9]+$) ]]; then
    echo "Invalid year: "$year
    exit -1
fi

if [[ !($batch =~ ^[0-9]+$) ]]; then
    echo "Invalid batch: "$batch
    exit -1
fi

if [[ !($ptype =~ ^[J|N|P|E|S]$) ]]; then
    echo "Invalid type: "$ptype
    exit -1
fi

# set problem number
if [ $ptype == "J" ]; then pno=1;fi
if [ $ptype == "N" ]; then pno=3;fi
if [ $ptype == "P" ]; then pno=6;fi
if [ $ptype == "E" ]; then pno=7;fi
if [ $ptype == "S" ]; then pno=8;fi

# echo input params
echo "Creating problem:"
echo "  Year:  "$year 
echo "  Batch: "$batch
echo "  Type:  "$ptype
echo "  Name:  "$name
echo "  Fname: "$fname
echo -n "Do you want to create template [Y/n]? "
read answer
if [ $answer == "Y" ];then
    echo "Creating problem file."
    id=`ls "problems/"$ptype"-R"$year"S"$batch"-"*"-"*".tex" 2>/dev/null | wc -l`
    fname="problems/"$ptype"-R"$year"S"$batch"-"$id"-"$fname".tex"
    cp $TEMPLATE_PATH/problem-templ.tex $fname
    sed -i "s/YY/"$year"/g" $fname
    sed -i "s/B/"$batch"/g" $fname
    sed -i "s/P/"$pno"/g"   $fname
    sed -i "s/probname{/probname{$name/g" $fname
    echo "Problem file created."
    exit 0
fi
exit -2

