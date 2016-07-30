#!/bin/bash

function add-header {

	FILE=$1
	TITLE=`head -n 1 $FILE | sed -E "s/[#]{1,}[ ]{0,}//"`

	if [ "$TITLE" = "---" ]; then
		echo "File already had YAML header!"
		return 1
	fi

	echo "---" >> header.tmp
	echo "title: $TITLE" >> header.tmp
	echo "---" >> header.tmp
	cat $FILE >> header.tmp
	mv header.tmp $FILE
}

if [ ! $1 ]; then
	echo "Usage: convert [ FILE | DIRECTORY ]"
fi

while [ $1 ]
do
	if [ -f "$1" ]; then

		add-header $1

	elif [ -d "$1" ]; then
		
		for f in $(find $1 -name '*.md')
		do
			add-header $f
		done
	else
		echo "Error: Not a valid File or Directory!"
	fi

	shift
done
