#!/bin/bash

# run in fykosXX with clean dir!!
# @1 problem series
# @2 problem id
# @3 problem name

source /etc/fks/config


ulohy=$templRepoPath
branch="problem"$1"-"$2"-branch"
workpwd=`pwd`

if [ $# -le 2 ]; then
    echo "Usage: fks-moveToFykos.sh <batch> <probNo> <name in fykos-ulohy>"
    exit -1
fi

if [[ !($1 =~ ^[1-6]+$) ]]; then
    echo "Batch must be in {1,6}."
    exit -1
fi
if [[ !($2 =~ ^[1-8]+$) ]]; then
    echo "Problem No. must be in {1,8}."
    exit -1
fi

cd $ulohy

file=`echo $3 | sed "s/[J|N|P|E|S][-]\([a-z|_]*\)/\1/g"`
echo $file
file="?-R*S*-?-$file.tex"
echo $file
file=`cd problems;ls $file`
echo $file
if [[ !($file =~ [a-z|_]+) ]]; then
    echo "Bad file format:" $file"."
    exit -1 
fi

oldbranch=`git branch | cut -d" " -f 2 | head -n 1`
git checkout -b $branch
#git filter-branch -f --prune-empty --index-filter 'git rm --cached --ignore-unmatch problems/.gitignore'
git filter-branch -f --prune-empty --index-filter 'git rm --cached --ignore-unmatch $(git ls-files | grep -v 'problems/$file')'
git filter-branch --subdirectory-filter problems -f

cat $file | 
tr '\n' '\r' | 
sed "s/[^\$.*\r].*% --- CUT HERE --- (do not edit this line and above this line)\r//g" |
sed "s/% --- CUT HERE ---[^\$.*\r].*//g" |
sed "s/probbatch{.}/probbatch{$1}/g" |
sed "s/probno{.}/probno{$2}/g" |
tr '\r' '\n' > tmp.tex
mv tmp.tex $file

git add $file
git mv $file problem"$1"-"$2.tex"
git commit -m "["$1"-"$2"] rename"
git checkout $oldbranch

cd $workpwd

git remote add ulohy-subtree $ulohy
git fetch ulohy-subtree $branch
git subtree merge -P problems/ ulohy-subtree/$branch -m "["$1"-"$2"] load problem from repository"
git remote rm ulohy-subtree

cd $ulohy

git branch -D $branch

git rm problems/$file
git commit -m "[$file] moved to repository"

cd $workpwd

echo "Zkontrolujte stav a pushněte ve 'fykos-ulohy' a zde."
