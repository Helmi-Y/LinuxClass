#!/usr/bin/awk -f
# transaction_report.awk
# Count transactions by state

BEGIN { 
    FS = OFS = ","
    data_format = "%s,%d\n"
}

{
    state = toupper($12)
    count[state]++
}

END{
    for (s in count)
        printf data_format, s, count[s]
}