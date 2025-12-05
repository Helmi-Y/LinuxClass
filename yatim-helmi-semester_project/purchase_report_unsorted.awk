#!/usr/bin/awk -f
# purchase_report.awk
# Show total purchases by gender and state

BEGIN { 
    FS = OFS = ","
    data_format = "%s,%s,%0.2f\n"
}

{
    #Calculate total purchase by gender and state
    
    state = toupper($12)
    gender = toupper($5)
    purchase = $6

    total[state, gender] += purchase
}

END{
    for (a in total)
    {
        #Split total array into two parts
        #Print as required format

        split(a, part, SUBSEP)
        state = part[1]
        gender = part[2]

        printf data_format, state, gender, total[a]
    }
}