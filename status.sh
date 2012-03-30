#!/bin/bash

WORKDIR=$1

LS="ls -l --time-style=long-iso"

TOTAL=`$LS $WORKDIR/ffprobeFile/ | wc -l`
echo "Total files to ingest=$TOTAL"


ERRORS=`$LS $WORKDIR/publishedPids/*.error | wc -l`
echo "Total files failed=$ERRORS"

SUCCES=`$LS $WORKDIR/publishedPids/* | grep -v error| wc -l`
echo "Total succes =$SUCCES"

START=`$LS $WORKDIR | grep ffprobeFile | sed -e 's/ \+/ /g' | cut -d' ' -f6,7`
echo "Ingest started at $START"

NEWEST=`$LS $WORKDIR/publishedPids |sed -e 's/ \+/ /g' | cut -d' ' -f6,7 | sort| tail -1`
echo "newest file through $NEWEST"

rm $WORKDIR/failedProbes.txt
for error in $WORKDIR/publishedPids/*.error; do \
    ERR=`basename $error | cut -d'.' -f1`
   cat $WORKDIR/ffprobeFile/$ERR >> $WORKDIR/failedProbes.txt
   echo "" >> $WORKDIR/failedProbes.txt
done
