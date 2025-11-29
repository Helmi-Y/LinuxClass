#!/usr/bin/awk -f
# remove_dollar.awk
# Removes '$' from purchase amount column

BEGIN { FS = OFS = ","}

{
    if (substr($6,1,1) == "$")
        $6 = substr($6,2)

    print
}