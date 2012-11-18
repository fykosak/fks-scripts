#!/bin/bash
# It converts the first argument into a grayscale eps and rename the original
# one adding "Old" in the beginning

if [ "$(echo $1|awk -F . '{print $NF}')" = "eps" ]; then
        gs -sOutputFile=$(basename $1 .eps)"grayscale.pdf" \
        -sDEVICE=pdfwrite -sColorConversionStrategy=Gray \
        -dProcessColorModel=/DeviceGray -dCompatibilityLevel=1.4 \
        -dNOPAUSE -dBATCH $1;
        mv $1 "Old-"$1;
        pdfcrop $(basename $1 .eps)"grayscale.pdf";
        pdftops -eps $(basename $1 .eps)"grayscale-crop.pdf" $1;
        rm $(basename $1 .eps)"grayscale.pdf";
        rm $(basename $1 .eps)"grayscale-crop.pdf";
else
        echo "Not an EPS file";
fi

