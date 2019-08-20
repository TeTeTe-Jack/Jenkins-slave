#!/bin/bash

# set parameters
name=$2
IP=$3


# delete previous backup files
cd $destinatoionPath
ls | grep -v -E ^$today | xargs rm -f

exit 0
