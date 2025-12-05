#!/bin/bash
# Helmi Yatim
# 12/04/2025
# Semester Project 5305


#error message
#if not equals 4
if [ "$#" -ne 6 ]; then
        echo "Error: must pass in six arguments"
        echo "Usage: $0 <private-key> <remote-server> <remote-userid> <remote-file> <mysql-user-id> <mysql-database>" 1>&2
        exit 1
fi

#Variables Declaration
private_key=$1
remote_srv=$2
remote_id=$3
remote_file=$4
MYSQL_USER=$5
MYSQL_DB=$6

# Validate private key exists
if [ ! -f "$private_key" ]; then
        echo "Error: Private key '$private_key' not found." 1>&2
        exit 1
fi

# Transfer the source file to your project directory. 
echo "Step 1: Transferring remote file..."
scp -i "$private_key" "$remote_id@$remote_srv:$remote_file" .
if [ $? -ne 0 ]; then 
        echo "Error: Failed to transfer remote file." 1>&2
        exit 1
fi
echo "Remote file '$remote_file' transfered successfully."

# The source file will be referred to as the transaction file 
# from this point forward and should be named so in your code.
filename=${remote_file##*/}
if [ ! -f "$filename" ]; then
        echo "Error: Transfered File '$filename' not found in local directory" 1>&2
        exit 1
fi
cp "$filename" ./transaction_file.csv.bz2
echo "Step 2: Original file preserved as transaction_file.csv.bz2"

# Unzip the transaction file. 
bunzip2 -k transaction_file.csv.bz2
if [ ! -f transaction_file.csv ]; then
        echo "Error: Failed to unzip transaction_file.csv.bz2" 1>&2
        exit 1
fi
echo "Step 3: File unzipped successfully."

# Remove the header record from the transaction file. 
tail -n +2 transaction_file.csv > transaction_noheader.csv
echo "Step 4: Header removed from transaction file."

# Convert all text in the transaction file to lowercase. 
tr '[:upper:]' '[:lower:]' < transaction_noheader.csv > transaction_lower.csv
echo "Step 5: Converted text to lowercase"

# Normalize Gender
if [ ! -f normalize_gender.awk ]; then
        echo "Error: normalize_gender.awk is missing" 1>&2
        exit 1
fi
echo "Step 6: Normalize gender"
./normalize_gender.awk transaction_lower.csv > transaction_gender.csv
if [ $? -ne 0 ]; then
        echo "Error: Failed to run this step." 1>&2
        exit 1
fi

# Filter states
if [ ! -f filter_states.awk ]; then
        echo "Error: filter_states.awk is missing" 1>&2
        exit 1
fi
echo "Step 7: State filter applied"
./filter_states.awk transaction_gender.csv > transaction_states.csv
if [ $? -ne 0 ]; then
        echo "Error: Failed to run this step." 1>&2
        exit 1
fi

# Remove the "$" sign from the purchase amt field.
if [ ! -f remove_dollar.awk ]; then
        echo "Error: remove_dollar.awk is missing." 1>&2
        exit 1
fi
echo "Step 8: Dollar signes removed from purchase amount"
./remove_dollar.awk transaction_states.csv > transaction_no_dollar.csv
if [ $? -ne 0 ]; then
        echo "Error: Failed to run this step." 1>&2
        exit 1
fi

# Sort transaction file by customerID
echo "Step 9: Transaction file sorted by customer id"
sort -t ',' -k 1,1 transaction_no_dollar.csv > transaction.csv
if [ $? -ne 0 ]; then
    echo "Error: Failed to sort transaction file." 1>&2
    exit 1
fi

# Summarize total purchase per customer
if [ ! -f summary.awk ]; then
        echo "Error: summary.awk is missing" 1>&2
        exit 1
fi
./summary.awk transaction.csv > summary_unsorted.csv
if [ $? -ne 0 ]; then
        echo "Error: Failed to run this step." 1>&2
        exit 1
fi

# Sort summary
sort -t ',' -k 2,2 -k 3,3nr -k 4,4 -k 5,5 summary_unsorted.csv > summary.csv
echo "Step 10: Summary file created."

# Create Transaction report Unsorted
if [ ! -f transaction_report_unsorted.awk ] || [ ! -f transaction_report.awk ]; then
        echo "Error: transaction report AWK scripts missing." 1>&2
        exit 1
fi
echo "Step 11: Transaction report created."
./transaction_report_unsorted.awk transaction.csv > transaction_report_unsorted.csv
if [ $? -ne 0 ]; then
        echo "Error: Failed to run this step." 1>&2
        exit 1
fi

# Sort Transaction Report
sort -t, -k 2,2nr -k 1,1 transaction_report_unsorted.csv > transaction_report_sorted.csv

# Created Sorted Transaction report
./transaction_report.awk transaction_report_sorted.csv > transaction.rpt
if [ $? -ne 0 ]; then
        echo "Error: Failed to run this step." 1>&2
        exit 1
fi

# Create Purchase Report unsorted
if [ ! -f purchase_report_unsorted.awk ] || [ ! -f purchase_report.awk ]; then
        echo "Error: Purchase report AWK scripts missing." 1>&2
        exit 1
fi
echo "Step 12: Purchase report created."
./purchase_report_unsorted.awk transaction.csv > purchase_report_unsorted.csv
if [ $? -ne 0 ]; then
        echo "Error: Failed to run this step." 1>&2
        exit 1
fi

# Sort Purchase Report
sort -t, -k 3,3nr -k 1,1 -k 2,2  purchase_report_unsorted.csv > purchase_report_sorted.csv

# Create Sorted Purchase Report
./purchase_report.awk purchase_report_sorted.csv > purchase.rpt
if [ $? -ne 0 ]; then
        echo "Error: Failed to run this step." 1>&2
        exit 1
fi

# Prompt for MySQL password
read -sp "Enter MySQL password: " MYSQL_PASS
echo

# Create tables for transaction and summary
if [ ! -f setup_tables.sql ]; then
        echo "Error: setup_tables.sql is missing" 1>&2
        exit 1
fi
mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" "$MYSQL_DB" < setup_tables.sql
if [ $? -ne 0 ]; then
        echo "Error: Failed to create tables in MySQL." 1>&2
        exit 1
fi
echo "Step 13: Database tables created."

#Import CSVs
mysqlimport --local --user="$MYSQL_USER" --password="$MYSQL_PASS" --fields-terminated-by=',' "$MYSQL_DB" transaction.csv
if [ $? -ne 0 ]; then
    echo "Error: Failed to import transaction.csv into MySQL." 1>&2
    exit 1
fi
mysqlimport --local --user="$MYSQL_USER" --password="$MYSQL_PASS" --fields-terminated-by=',' "$MYSQL_DB" summary.csv
if [ $? -ne 0 ]; then
    echo "Error: Failed to import summary.csv into MySQL." 1>&2
    exit 1
fi

echo "Step 14: CSV files loaded into MySQL database."

#Clean up
echo "ETL process completed successfully."
echo "Reports generated:"
echo " - transaction.rpt"
echo " - purchase.rpt"
echo " --------- "

echo "CSV files saved:"
echo " - transaction.csv" 
echo " - exceptions.csv" 
echo " - summary.csv"
echo " --------- "


read -p "Would you like to clean up the temporary files used for the ETL process? (y/n): " ans

if [[ "$ans" == "y" ]]; then
        echo "Running cleanup..."
        ./cleanup.sh
else
        echo "Skipping cleanup."
        echo "To clean later, run: ./cleanup.sh"
fi