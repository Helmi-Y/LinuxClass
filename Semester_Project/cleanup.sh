#!/bin/bash
#Helmi Yatim
#Clean up function

# Remove all csv files except transaction.csv, and exception.csv, summary.csv
for csv in *.csv; do
    if [[ "$csv" != "transaction.csv" &&
          "$csv" != "summary.csv" &&
          "$csv" != "exception.csv" ]]; then
        rm "$csv"
        echo "Removed temp CSV: $csv"
    fi
done

# Remove .bz2 files, remote source and copied
for bz in *.bz2; do
    rm "$bz"
    echo "Removed bz2 file: $bz"
done