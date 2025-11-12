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

calculate_number_of_files(){
    #Local variables
    local dir="$1"
	local Str
	local ordinary_files=0
	local directories=0
    local empty_files=0
    local total=0

	#Save ls output as an array of files
	Str=$(ls "$dir")

	#Loop through array and calculate each type
	for file in $Str; do
        #If it's a ordinary file
        if [ -f "$dir/$file" ]; then
            ((ordinary_files++))
            #If file is empty
            if [ ! -s "$dir/$file" ]; then
                ((empty_files++))
            fi
        #If it's a directory
        elif [ -d "$dir/$file" ]; then
            ((directories++))
        fi
        ((total++))
	done


	#Print information
	echo "Directory: $dir"
    echo "Number of ordinary files: $ordinary_files"
    echo "Number of directories: $directories"
    echo "Number of empty files: $empty_files"
    echo "Total file count: $total"
}

#Main
calculate_number_of_files "$1"

exit 0