#!/bin/bash
read -p "Enter A,B, or C: " letter
case "$letter" in
    A)
        echo "You entered A"
        ;;
    B)
        echo "You entered B"
        ;;
    C)
        echo "You entered C"
        ;;
    *)
        echo "You did not enter A,B,or C"
        ;;
esac

