#!/bin/bash

MSG=`.bin/resourcecheck.sh`
NAME=$1

if [ $MSG = 1 ]; then
 echo "OK"

 else
 echo "create instance faild" >> error.log
 exit1

fi

