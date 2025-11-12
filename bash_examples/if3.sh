#!/bin/bash
read -p "word1: " word1
read -p "word2: " word2
read -p "word3: " word3
if [ "$word1" = "$word2" -a "$word2" = "$word3" ]
    then
        echo "Match: words 1, 2, & 3"
    elif [ "$word1" = "$word2" ]
    then
        echo "Match words 1 & 2"
    elif [ "$word1" = "$word3" ]        
    then
        echo "Match words 1 & 3"
    elif [ "$word2" = "$word3" ]
    then
        echo "Match words 2 & 3"
    else
        echo "No match"
fi
