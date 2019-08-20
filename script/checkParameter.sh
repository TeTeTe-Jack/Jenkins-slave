#!/bin/bash

# check number of args
if test $# -eq 0 ;then
  echo "arg is blank" 1>&2
  exit 1
fi

# check if execution is with -ex
if test $1 = '-xe' ;then
  numOpt=1
  arg=$2
else
  numOpt=0
  arg=$1
fi

# check number of args
if test $# -eq $numOpt ;then
  echo "arg is blank" 1>&2
  exit 1
fi

# check num of args
if test $# -gt $((1+numOpt)) ;then
	echo "number of args=$(($#-numOpt))" 1>&2
  echo "Try with 1 arg" 1>&2
  exit 2
fi

# check none
if test $arg = 'None' ;then
  echo "arg is None" 1>&2
  exit 3
fi

exit 0
