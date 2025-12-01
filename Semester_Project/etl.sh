#!/bin/bash
# Helmi Yatim
# 12/04/2025
# Semester Project 5305


#error message
#if not equals 4
if [ "$#" -ne 4 ]; then
        echo "Usage: $0 directory" 1>&2
        echo "Must pass in four arguments (private-key, remote-server, remote-userid, remote-file)"
        exit 1
fi

#Variables Declaration
private_key=$1
remote_srv=$2
remote_id=$3
remote_file=$4

# Transfer the source file to your project directory. 
scp -i "$private_key" "$remote_id@$remote_srv:$remote_file" .


# The source file will be referred to as the transaction file 
# from this point forward and should be named so in your code.
filename=${remote_file##*/}
cp "$filename" ./transaction.csv.bz2

# Unzip the transaction file. 
bunzip2 -k transaction.csv.bz2

# Remove the header record from the transaction file. 
tail -n +2 transaction.csv > transaction_noheader.csv

# Convert all text in the transaction file to lowercase. 
tr '[:upper:]' '[:lower:]' < transaction_noheader.csv > transaction_lower.csv

# Normalize Gender
./normalize_gender.awk transaction_lower.csv > transaction_gender.csv

# Filter states
./filter_states.awk transaction_gender.csv > transaction_states.csv

# Remove the "$" sign from the purchase amt field. 
./remove_dollar.awk transaction_states.csv > transaction_no_dollar.csv

# Sort transaction file by customerID
sort -t ',' -k 1,1 transaction_no_dollar.csv > transaction.csv

# Summarize total purchase per customer
./summary.awk transaction.csv > summary_unsorted.csv

# Sort summary
sort -t ',' -k 2,2 -k 3,3nr -k 4,4 -k 5,5 summary_unsorted.csv > summary.csv

# Create Transaction report Unsorted
./transaction_report_unsorted.awk transaction.csv > transaction_report_unsorted.csv

# Sort Transaction Report
sort -t, -k 2,2nr -k 1,1 transaction_report_unsorted.csv > transaction_report_sorted.csv

# Created Sorted Transaction report
./transaction_report.awk transaction_report_sorted.csv > transaction.rpt