#!/bin/bash
for i in $(ls) # command substituation
do
    if [ -d "$i" ]
        then
            echo "$i"
    fi
done

