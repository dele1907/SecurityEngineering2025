#!/bin/sh

if test $# -ne 1; then 
  echo "usage: $0 <cpu|stack|file>"
  exit 1
fi

if ! test -x "./main"; then
  echo "couldn't find executable file"
  exit 1
fi

if test $1 == "cpu"; then
  ulimit -t 3
  ./main cpu
elif test $1 == "stack"; then
  ulimit -s 128
  ./main stack
elif test $1 == "file"; then
  ulimit -f 20
  ./main file
fi

