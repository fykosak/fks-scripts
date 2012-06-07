#!/bin/bash



if [ "x$1" = "x" ] ; then
	echo "Usage: $(basename $0) batchno"
	echo "Run in problems directory."
	exit 1
fi


for file in graphics/problem$1-*.eps ; do
	convert -density 300 "$file" "$file.png"
	convert -density 100 "$file" "${file}_thumb.png"
done

rename 's/problem(.)-(.)-(.*)\.eps((_thumb)?)\.png/s$1u$2_$3$4.png/' graphics/problem$1-*.eps*.png
