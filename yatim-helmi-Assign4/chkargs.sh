#!/bin/bash
# Helmi Yatim
# 10/07/2025
# Assignment 4


#error message
#if less than two
if [ "$#" -lt 2 ]; then
	echo "Usage: needs dir file" 1>&2
	exit 1
fi 

#Set args into variables
dir=$1
file=$2

#validate args
if [ ! -d ${dir} ]; then
	echo "Usage: first arg must be a directory" 1>&2
	exit 1
fi

if [ ! -f ${file} ]; then
	echo "Usage: second arg must be a normal file" 1>&2
	exit 1
fi

#ls command
echo "Viewing contents of directory: ${dir}"
ls -lF ${dir}

echo

#cat command
echo "Reading contents of text file ${file}:"
cat ${file}
echo

exit 0
