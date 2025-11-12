# Return all lines with line numbers that do not start with an uppercase letter.
echo "Problem 6"
grep -nv '^[[:upper:]]'  raven.txt
