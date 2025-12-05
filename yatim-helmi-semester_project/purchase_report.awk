#!/usr/bin/awk -f
# purchase_report.awk
# Show the total purchases by gender and state

BEGIN { 
    FS = ","
    header_format = "%-10s %-10s %-10s\n"
    data_format = "%-10s %-10s %-0.2f\n"

    # Print header
    print "Report by: Helmi Yatim"
    print "Purchase Summary Report"
    print ""
    printf header_format, "State","Gender","Report"
}

{
    state = $1
    gender = $2
    report = $3

    printf data_format, state, gender, report
}