#!/usr/bin/awk -f
# filter_states.awk
# Filter all records out of the transaction file from the “state” field that do not have a state or contain “NA”

BEGIN { FS = OFS = ","}

{
    state = $12
    if (state == "" || toupper(state) == "NA")
        print > "exceptions.csv"
    else
        print
}