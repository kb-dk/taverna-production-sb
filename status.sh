#!/bin/bash

WORKDIR=$1

LS="ls -l --time-style=long-iso"

function errorsAtStage {
	STAGE=$1
	ERRORS=`$LS $WORKDIR/$STAGE_*/*.error 2> /dev/null | wc -l`
	echo $ERRORS
}

function succesesAtStage {
	STAGE=$1
	SUCCES=`$LS $WORKDIR/$STAGE_*/* 2> /dev/null | grep -v error| wc -l`
	echo $SUCCES
}


for i in {1..6}; do \
	echo "Stage $i"
	echo "Total succes `succesesAtStage $i`"
	echo "Total errors `errorsAtStage $i`"
	echo
done

START=`$LS $WORKDIR 2> /dev/null | grep ffprobeFile | sed -e 's/ \+/ /g' | cut -d' ' -f6,7`
echo "Ingest started at $START"

NEWEST=`$LS $WORKDIR/6_* 2> /dev/null |sed -e 's/ \+/ /g' | cut -d' ' -f6,7 | sort| tail -1`
echo "newest file through $NEWEST"

#rm $WORKDIR/failedProbes.txt 2> /dev/null 
#touch $WORKDIR/failedProbes.txt 2> /dev/null 
#for error in $WORKDIR/publishedPids/*.error; do \
#    ERR=`basename $error | cut -d'.' -f1`
#   cat $WORKDIR/ffprobeFile/$ERR >> $WORKDIR/failedProbes.txt
#   echo "" >> $WORKDIR/failedProbes.txt
#done
