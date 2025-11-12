#!/bin/bash

PS3="Enter your selection: " 

select FRUIT in apple banana blueberry STOP
do
    if [ "$FRUIT" == "" ] ; then
        echo -e "Invalid entry\n"
        continue
    elif [ "$FRUIT" == STOP ] ; then
        echo -e "Thanks for playing\n"
        break
fi

echo "You chose $FRUIT"
echo -e "That is choice number $REPLY\n"
done

