#!/bin/bash
# Replace each [ ] with the indicated information and delete this line
# [Helmi Yatim]
# [Lab 8]
# [10/22/2025]

# Declare Variables
full_path="/usr/local/bin/zip"
file="README.txt"
tarfile="inclass-assign4.tar.gz"

# Use string pattern matching to complete this script

# 1 - Extract the filename from the the variable $full_path
filename=${full_path##*/}
echo "filename=$filename"

# 2 - Extract the pathname from the variable $full_path
pathname=${full_path%/*}
echo "pathname=$pathname"

# 3 - Extract the file extension from the README.txt file (i.e. .txt)
ext=${file##*.}
echo "ext=$ext"

# 4 - Extract the filename without the file extension from README.txt (i.e. README)
barefile=${file%.*}
echo "barefile=$barefile"

# 5 - Extract the filename without the .tar.gz extension from the variable $tarfile
myfile=${tarfile%.tar.gz}
echo "myfile=$myfile"

exit 0
