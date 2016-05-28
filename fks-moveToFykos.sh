#!/bin/bash

# run in fykosXX with clean dir!!
# @1 problem series
# @2 problem id
# @3 problem name

source /etc/fks/config

ulohy=$templRepoPath
branch="problem"$1"-"$2"-branch"
workpwd=`pwd`
source /usr/local/share/fks/semyr
semyr ""

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

if [ "`pwd`" != "`git rev-parse --show-toplevel`" ]; then
    echo "Run in repository toplevel: "`git rev-parse --show-toplevel`
    exit -1
fi

if [ `git status | grep -E 'Untracked|Changes' | wc -l` != 0 ]; then
    echo "git status is not clean in fykosXX."
    echo "Run \`git reset --hard HEAD && git clean -f\` only if you know what are you doing..."
    exit 1
fi

cd $ulohy

if [ `git status | grep -E 'Untracked|Changes' | wc -l` != 0 ]; then
    echo "git status is not clean in fykos-ulohy."
    echo "Run \`git reset --hard HEAD && git clean -f\` only if you know what are you doing..."
    exit 1
fi

file=`sed "s/[J|N|P|E|S][-]\([a-z|_]*\)/\1/g" <<< $3`
file="?-R*S*-?-$file.tex"
file=`cd problems;ls $file`
if [[ !($file =~ [a-z|_]+) ]]; then
    echo "Bad file format:" $file"."
    exit -1 
fi

prefix=`sed 's/\([J|N|P|E|S]-R[0-9]*S[0-9]-[0-9]\).*/\1/' <<< $file`
#echo -e $prefix"\n"


oldbranch=`git branch | cut -d" " -f 2 | head -n 1`
git checkout -b $branch
echo "git filter-branch: remove other files"
git filter-branch -f --prune-empty --index-filter 'git rm --cached --ignore-unmatch $(git ls-files | grep -v '$prefix')' >/dev/null 2>&1
git filter-branch --subdirectory-filter problems -f

SEMINAR=`tr '[:lower:]' '[:upper:]' <<< $seminar`$rocnik
cat $file | 
tr '\n' '\r' | 
sed "s/[^\$.*\r].*% --- CUT HERE --- (do not edit this line and above this line)\r//g" |
sed "s/% --- CUT HERE ---[^\$.*\r].*//g" |
sed "s/probbatch{.}/probbatch{$1}/g" |
sed "s/probno{.}/probno{$2}/g" |
sed "s/probcontest{[^}]*}/probcontest{$SEMINAR}/g" |
tr '\r' '\n' > tmp.tex
mv tmp.tex $file

cat << EOF

################################################################################
### Modified files from fykos-ulohy ############################################
################################################################################

EOF

git ls-files

cat << EOF

################################################################################

EOF

makefileinc=""
for f in `git ls-files`; do
    ext="${f##*.}"
    echo -e "\n############ "$f":"
    case $ext in
        "tex"|"plt")
            sed  -i "s/$prefix/problem$1-$2/g" $f
            git diff $f
            git add $f
            ;;
        *)
            makefileinc=$makefileinc" "$f
            ;;
    esac
    git mv $f `sed "s/$prefix/problem$1-$2/g" <<< $f`
done
echo ""
makefileinc=`sed "s/$prefix/problem$1-$2/g" <<< $makefileinc`

cat << EOF

################################################################################
makefileinc = $makefileinc
################################################################################

EOF

git mv problem"$1"-"$2"* problem"$1"-"$2.tex"
git commit -m "["$1"-"$2"] rename"
git checkout $oldbranch

cd $workpwd

git remote add ulohy-subtree $ulohy
git fetch ulohy-subtree $branch
git subtree merge -P problems/ ulohy-subtree/$branch -m "["$1"-"$2"] load problem from repository"
conflict=`git status | grep "both added" | tr -s " " | cut -d " " -f 3`

cat << EOF

################################################################################
### Merge conflict -- checkout theirs ##########################################
### (no problem; only rewrites empty problemX-Y.tex in fykosXX #################
################################################################################
### $conflict
################################################################################

EOF

git checkout --theirs $conflict
git add $conflict
git remote rm ulohy-subtree

cd $ulohy
git branch -D $branch
git ls-files | grep $prefix | xargs git rm
git commit -m "[$file] moved to repository"
cd $workpwd

cat << EOF

################################################################################
### Modifications in problems/Makefile.inc #####################################
################################################################################

EOF

sed -i "s|\(^problem$1_$2=.*\)\$|\1 $makefileinc|g" problems/Makefile.inc
git diff problems/Makefile.inc
git add problems/Makefile.inc
git commit -m "["$1"-"$2"] merge to repo"

cat << EOF

################################################################################
Zkontrolujte stav repozitářů
  * fykosXX:
    * problems/Makefile.inc
    * problems/problem$1_$2.tex
`ls problems/graphics/color/problem$1-$2* problems/graphics/problem$1-$2* | sed 's/\(.*\)/    * \1/g'`

    * vše je commitnuto
    * je to přeložitelné

  * fykos-ulohy
    * odstranění úlohy
    * odstranění veškeré odpovídající grafiky
    * vše je commitnuto

Automaticky prováděné změny v souborech byly uvedeny výše mezi ################.

Po kontrole pushněte ve 'fykos-ulohy' a zde.
EOF
