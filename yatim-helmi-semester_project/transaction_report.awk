#!/usr/bin/awk -f
# transaction_report.awk
# Count transactions by state

BEGIN { 
    FS = OFS = ","
    header_format = "%-10s %-10s\n"
    data_format = "%-10s %-10d\n"

    # Print header
    print "Report by: Helmi Yatim"
    print "Transaction Count Report"
    print ""
    printf header_format, "State","Transaction Count"
}

{
    state = $1
    count = $2

    printf data_format, state, count
}