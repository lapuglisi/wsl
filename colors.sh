#!/usr/bin/env bash

echo "--------------------------------------------------------------------------";
for fgcolor in {30..39};
do
	echo -en "\033[0m| ";
	for bgcolor in {40..49};
	do
		echo -ne "\033[${fgcolor};${bgcolor}m ${fgcolor};${bgcolor} \033[0m";
	done

	echo " |";
done

echo "--------------------------------------------------------------------------";
