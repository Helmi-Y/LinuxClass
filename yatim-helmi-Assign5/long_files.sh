#!/bin/bash
# Helmi Yatim
# 10/20/2025
# Assignment 5

#error message
#if not equal to one
if [ "$#" -ne 1 ]; then
        echo "Usage: $0 directory" 1>&2
        exit 1
fi

#Set args into variables
dir=$1

#Validate args
if [ ! -d ${dir} ]; then
        echo "First parameter must be a directory (dir)" 1>&2
        exit 1

fi

#Function to calculate longest filename
calculate_longest_filename(){
	local dir="$1"
	local Str
	local longest_length=0
	local -a longest_files=()

	#Save ls output as an array of files
	Str=$(ls "$dir")

	#Loop through array and find longest filename
	for file in $Str; do
		length=${#file}
		if [ $length -gt $longest_length ]; then
			longest_length=$length
			longest_files=("$file")
		elif [ $length -eq $longest_length ]; then
			longest_files+=("$file")
		fi
	done

	#Print information
	echo "Directory: $dir"
	echo "Longest filename len: $longest_length"
	echo "Longest filename(s): ${longest_files[*]}"
}

#Main
calculate_longest_filename "$1"

exit 0