#!/bin/bash
# Helmi Yatim
# 10/24/2025
# Assignment 6

echo "Creating ADE school file"

#Extract school name from ade-distrcit.csv

cut -f 2 -d ',' ade-district.csv > ade-schools.csv

echo "Creating ADE enrollment file"

#Extract school name, district name, and total enrollment

cut -f 2,3,6 -d ',' ade-district.csv > ade-enroll.csv

echo "Creating ADE output file"

#Remove header and sort by district asc, and total enrollment desc

tail -n +2 ade-district.csv | sort -t ',' -k 3,3 -k 6,6nr > ade-output.csv

echo "Finished! Thank you."


exit 0
