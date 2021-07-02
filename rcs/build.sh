#!/bin/bash

rcs=`find . -type f | grep -e rc$ -e conf$`

for rc in $rcs
do
	target=$(pwd)/${rc:2}
	link_name=$HOME/.${rc:2}

	echo target name: $target
	echo link name: $link_name

	ln -s $target $link_name -f
done



