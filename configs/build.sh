#!/bin/bash

echo \# Build configuration files

rcs=`find . -type f | grep -e rc$ -e conf$`

for rc in $rcs
do
	target=$(pwd)/${rc:2}
	link_name=$HOME/.${rc:2}
	ln -s $target $link_name -f -v
done



