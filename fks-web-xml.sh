#!/bin/bash

graphicsDir='../problems/graphics'
directories='/web/ /color/ /'
exts='svg png jpg jpeg'

function lookupFigures {
    firstRun=1
    fnameBare=`echo $1 | sed 's/\.[a-z]\+$//'`
    for ext in $exts
    do
        for dir in $directories
        do
            path="$graphicsDir$dir$fnameBare.$ext"
            if [ -f $path ] ; then
                if [ $firstRun -eq 1 ]; then
                    firstRun=0
                    echo "<figure xml:lang=\"$3\">"
                    echo "<caption><![CDATA[$2]]></caption>"
                fi

                if [ $ext = 'svg' ]; then
                    data="<![CDATA["`cat $path | sed 's/]]>/]]]]><![CDATA[>/g'`"]]>"
                else
                    data=`base64 $path`
                fi
                echo "<data extension=\"$ext\">$data</data>"
                break
            fi
        done
    done
    if [ $firstRun -eq 0 ]; then
        echo "</figure>"
    fi
}

while read -r line; do \
    #if [[ $line =~ "<figure xml:lang=\".n\">FIGURE" ]]; then
    if echo $line | grep '<figure xml:lang="..">FIGURE' > /dev/null ; then
        fname=`echo $line | sed -n 's/.*FIGURE\(.*\)CAPTION.*/\1/p'`
        cap=`echo $line | sed -n 's/.*CAPTION\(.*\)EFIGURE.*/\1/p'`
        lang=`echo $line | sed -n 's/.*<figure xml:lang="\(.*\)">.*/\1/p'`
        lookupFigures "$fname" "$cap" "$lang"
    elif echo $line | grep '<figure xml:lang="..">\\illfig {' > /dev/null ; then
        fname=`echo $line | sed -n 's/.*\\illfig\s*{\(.*\)}\s*{\(.*\)}\s*{.*}\s*{.*}.*/\1/p'`
        cap=`echo $line | sed -n 's/.*\\illfig\s*{\(.*\)}\s*{\(.*\)}\s*{.*}\s*{.*}.*/\2/p'`
        lang=`echo $line | sed -n 's/.*<figure xml:lang="\(.*\)">.*/\1/p'`
        lookupFigures "$fname" "$cap" "$lang"
    else
        echo $line
    fi
done < <(sed '/N\/A/d' $1)

# TODO postprocess: tr -d '\n' | sed 's/<\(.*\)>\s*<\/\1>//g'
# done in make
