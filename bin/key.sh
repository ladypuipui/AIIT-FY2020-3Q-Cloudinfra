#!/bin/bash

NAME=$1
MSG=`bin/duplicatecheck.sh ./resource/key/ $NAME`




if [ $MSG = 0 ]; then
 echo "OK"

mkdir  ./resource/key/$NAME
cd ./resource/key/$NAME

ssh-keygen -t rsa -N "" -f $NAME


 else
 echo "the keypair  is duplicated." >> error.log
 exit 1 

fi


