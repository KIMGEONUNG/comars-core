#!/bin/bash

rcs=`find . -type f | grep rc$`

for rc in $rcs
do
	target=$(pwd)/${rc:2}
	link_name=$HOME/.${rc:2}

	echo target name: $target
	echo link name: $link_name

	ln -s $target $link_name -f
done



