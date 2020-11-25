#!/bin/bash
path=$1
fileName=$2

KEYNAMERESULT=`ls $1 | grep -w $2`

if [ -z $KEYNAMERESULT ]; then
  DUPLISTATUS=`echo 0`
	
  else
   DUPLISTATUS=`echo 1`
fi

echo $DUPLISTATUS
