#!/bin/bash

# Input Directory
INPUT=$1

function add-header {

	FILE=$1
	TITLE=`head -n 1 $FILE | sed -E "s/[#]{1,}[ ]{0,}//"`

	echo "---" >> header.tmp
	echo "title: $TITLE" >> header.tmp
	echo "---" >> header.tmp
	cat $FILE >> header.tmp
	mv header.tmp $FILE
}

if [ -f "$INPUT" ]; then

	add-header $INPUT

elif [ -d "$INPUT" ]; then
	
	for f in $(find $INPUT -name '*.md')
	do
		add-header $f
	done
else
	echo "Error: Not a valid File or Directory!"
	echo "Usage: convert [ FILE | DIRECTORY ]"
fi
