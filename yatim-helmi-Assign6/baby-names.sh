#!/bin/bash
# Helmi Yatim
# 10/24/2025
# Assignment 6

echo "Common boy baby names between 2006 and 2016 are:"

#Remove headers, extract boy name column, sort alphabetically
tail -n +2 2006-baby-names.txt | cut -f 2 | sort > 2006-baby-names-sorted

tail -n +2 2016-baby-names.txt | cut -f 2 | sort > 2016-baby-names-sorted

#Join the two sorted files together
join 2006-baby-names-sorted 2016-baby-names-sorted

exit 0
