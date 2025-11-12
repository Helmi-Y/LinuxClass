#!/bin/bash
# Helmi Yatim
# 10/24/2025
# Assignment 6

#Print text, then trim the continous space into one single space.
#Extract the three columns needed, then sort by size numeric desc
cat ls_output.txt | tr -s ' ' | cut -d ' ' -f 1,5,9 | sort -t ' ' -k 2,2nr

exit 0