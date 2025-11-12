# Count the number of lines that do not contain the string "raven", but do not include strings that contain partial matches, e.g., 'ravens' (Hint, use inverse flag). Return only the count.
echo "Problem 10"
grep -cvw 'raven' raven.txt
