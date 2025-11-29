#!/usr/bin/awk -f
# normalize_gender.awk
# Converts Gender field to m,f or u

BEGIN { FS = OFS = ","}

{
    gender = $5
    if (gender == 1 || tolower(gender) == "female")
        $5 = "f"
    else if (gender == 0 || tolower(gender) == "male")
        $5 = "m"
    else
        $5 = "u"

    print
}