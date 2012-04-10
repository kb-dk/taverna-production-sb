#!/bin/bash

WORKDIR=$1

LS="ls -l --time-style=long-iso"

TOTAL=`$LS $WORKDIR/ffprobeFile/ 2> /dev/null| wc -l`
echo "Total files to ingest=$TOTAL"


ERRORS=`$LS $WORKDIR/publishedPids/*.error 2> /dev/null | wc -l`
echo "Total files failed=$ERRORS"

SUCCES=`$LS $WORKDIR/publishedPids/* 2> /dev/null | grep -v error| wc -l`
echo "Total succes =$SUCCES"

START=`$LS $WORKDIR 2> /dev/null | grep ffprobeFile | sed -e 's/ \+/ /g' | cut -d' ' -f6,7`
echo "Ingest started at $START"

NEWEST=`$LS $WORKDIR/publishedPids 2> /dev/null |sed -e 's/ \+/ /g' | cut -d' ' -f6,7 | sort| tail -1`
echo "newest file through $NEWEST"

rm $WORKDIR/failedProbes.txt 2> /dev/null 
touch $WORKDIR/failedProbes.txt 2> /dev/null 
for error in $WORKDIR/publishedPids/*.error; do \
    ERR=`basename $error | cut -d'.' -f1`
   cat $WORKDIR/ffprobeFile/$ERR >> $WORKDIR/failedProbes.txt
   echo "" >> $WORKDIR/failedProbes.txt
done
