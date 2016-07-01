#!/bin/bash

# Input Directory
INPUT=$1

# How many dirs to recurse into
DEPTH=1

echo "# Table of Contents" > toc.tmp

function add-header {

	FILE=$1
	TITLE=`head -n 1 $FILE | sed -E "s/[#]{1,}[ ]{0,}//"`

	echo "---" >> header.tmp
	echo "title: $TITLE" >> header.tmp
	echo "---" >> header.tmp
	cat $FILE >> header.tmp
	mv header.tmp $FILE

	echo "" >> toc.tmp
	echo "[${TITLE}](${FILE})" >> toc.tmp

}

if [ -f "$INPUT" ]; then

	add-header $INPUT

elif [ -d "$INPUT" ]; then
	
	for f in $(find $INPUT -maxdepth $DEPTH -name '*.md')
	do
		add-header $f
	done
else
	echo "Error: Not a valid File or Directory!"
	echo "Usage: convert [ FILE | DIRECTORY ]"
fi

# Allows TOC File to be not included in itself
mv toc.tmp toc.md
