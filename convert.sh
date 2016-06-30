#!/bin/bash

# Config
INPUT=$1

function add-header {

	echo "---" > header.tmp
	head -n 1 $1 >> header.tmp
	sed -i -E "s/[#]{1,}[ ]{0,}/title: /" header.tmp
	echo "---" >> header.tmp
	cat $1 >> header.tmp
	mv header.tmp $1
}

if [ -f "$INPUT" ]; then

	add-header $INPUT

elif [ -d "$INPUT" ]; then
	
	for f in $(find $INPUT -name '*.md')
	do
		add-header $f
	done
else
	echo "Error: No a valid File or Directory!"
	echo "Usage: convert [ FILE | DIRECTORY ]"
fi
