#!/bin/bash
read -p "word1:" word1
read -p "word2:" word2
if test "$word1" = "$word2"
    then
        echo "Match"
fi
