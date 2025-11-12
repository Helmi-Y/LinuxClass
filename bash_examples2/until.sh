#!/bin/bash
secret=whizbang
guess=
until [ "$guess" = "$secret" ]
do
    read -p "Your guess: " guess
done
echo "You got it!"
