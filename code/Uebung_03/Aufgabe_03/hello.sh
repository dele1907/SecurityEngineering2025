#!/bin/sh

if test "$#" -eq 0; then # schaut, ob die anzahl der arugmente gleich 0 ist§
  echo "Es muss mindestens ein Argument übergeben werden"
  exit 1
fi

for argument in "$@"; do # in $@ stehen die argumente, dass man so mit einem for loop drüber gehen kann
  echo  "Hallo $argument"
done
exit 0