Semester Project 5305 - ETL Script
Author: Helmi Yatim
Date: 12/04/2025

Project Overview:
-------------------------------
This project automates the ETL (Extract, Transform, Load) process for transaction data.
The main script, etl.sh, performs the following:

1. Transfer the remote transaction file to the local project directory
2. Unzips and prepares the transaction data
3. Clean and normalize the data:
    - Converts all text to lowercase
    - Normalizes gender to m, f, or u
    - Filters out invalid or missing state records
    - Removes the $ sign from purchase amounts
4. Sorts the transaction file by customer id 
5. Summarizes total purchases per customer
6. Generates two reports:
    - transaction.rpt - number of transactions per state
    - purchase.rpt - total purchases by gender and state
7. Loads the cleaned transaction and summary data into MySQL/MariaDB
8. Optionally cleans up temporary files used in ETL process

Directory structure:
-------------------------------
This folder should include the following files:

    - etl.sh - Main ETL script
    - cleanup.sh - Script to remove temporary files created during ETL process
    - normalize_gender.awk - Normalize gender values
    - filter_states.awk - Filter invalid states
    - remove_dollar.awk - Remove $ signs from purchase amounts
    - summary.awk - Generate summary per customer
    - transaction_report_unsorted.awk - Count transactions by state (unsorted)
    - transaction_report.awk - Format transaction report
    - purchase_report_unsorted.awk - Generate total purchase by state and gender (unsorted)
    - purchase_report.awk - Format purchase report
    - setup_tables.sql - Create MySQL/MariaDB tables for import

All scripts should be in the same directory

Running the ETL Script:
-------------------------------
1. Open the terminal and navigate to the project directory
2. Ensure that each script is executable:
    
    chmod u+x *.sh *.awk

3. Run the script using the following syntax:

    ./etl.sh <private-key> <remote-server> <remote-userid> <remote-file> <mysql-user-id> <mysql-database>

    Example:

    ./etl.sh ~/.ssh/id_rsa 167.99.48.123 hyatim1 /home/shared/MOCK_MIX_v2.1.csv.bz2 root maxdb

    Arguments:
    - <private-key>: Path to your SSH private key
    - <remote-server>: Remote server IP or hostname
    - <remote-userid>: Username on the remote server
    - <remote-file>: Path to the transaction file on the remote server
    - <mysql-user-id>: MySQL/MariaDB username
    - <mysql-database>: Database name in MySQL/MariaDB

4. You will be prompted to enter the MySQL password (input will be hidden)
5. The script will execute all ETL steps, generate reports, and load data into MySQL
6. After successful execution, you will be prompted whether to clean up temporary files
7. If you choose "y", In addition to the original scripts, the following files will remain in the directory:
    - transaction.csv (cleaned and sorted transaction file)
    - summary.csv (customer summary)
    - exceptions.csv (records removed due to invalid/missing state)
    - transaction.rpt (transaction count report)
    - purchase.rpt (purchase total report)

Cleanup (optional):
-------------------------------
If you replied with anything other than 'y', the files will not be deleted

You can still manually clean temporary files after ETL execution by executing this file:

    ./cleanup.sh

This will remove all temporary CSV and compressed files.
