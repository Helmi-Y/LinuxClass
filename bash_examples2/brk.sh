#!/bin/bash
for index in {1..10}
do
    if [ $index -le 3 ] ; then
        echo "continue"
        continue
    fi
    echo $index
    if [ $index -ge 8 ] ; then
        echo "break"
        break
    fi
done
