#!/usr/bin/awk -f
# summary.awk
# Summarizes total purchase per customer

BEGIN { FS = OFS = ","}

{
    # Map columns based on customer
    cust = $1
    state[cust] = $12
    zip[cust] = $13
    lname[cust] = $3
    fname[cust] = $2
    total[cust] += $6
}

END{
    for (c in total) {
        printf "%s,%s,%s,%s,%s,%.2f\n", c, state[c], zip[c], lname[c], fname[c], total[c]
    }
}