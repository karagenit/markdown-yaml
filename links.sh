#!/bin/bash

for file in $(find . -name '*.md')
do
	sed -i "s/.md/.html/" $file
done
