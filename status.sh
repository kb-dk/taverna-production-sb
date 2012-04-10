#!/bin/bash

WORKDIR=$1

LS="ls -l --time-style=long-iso"

function errorsAtStage {
	local STAGE=$1
	local ERRORS=`$LS $WORKDIR/${STAGE}_*/*.error 2> /dev/null | wc -l`
	_RET=$ERRORS
}

function succesesAtStage {
	local STAGE=$1
	local SUCCES=`$LS $WORKDIR/${STAGE}_*/* 2> /dev/null | grep -v error| wc -l`
	_RET=$SUCCES
}


for i in {10..99}; do \
	dir=`ls -d $WORKDIR/${i}_* 2> /dev/null`
	if [ ! -d $dir ]
	then 
		continue
	fi
	file=`basename $dir`
	echo "Stage $i"
	succesesAtStage $i
	echo "Total succes $_RET"
	errorsAtStage $i
	echo "Total errors $_RET"
	_RET=0
	echo
done

START=`$LS $WORKDIR 2> /dev/null | grep ffprobeFile | sed -e 's/ \+/ /g' | cut -d' ' -f6,7`
echo "Ingest started at $START"

NEWEST=`$LS $WORKDIR/10_* 2> /dev/null |sed -e 's/ \+/ /g' | cut -d' ' -f6,7 | sort| tail -1`
echo "newest file through $NEWEST"

#rm $WORKDIR/failedProbes.txt 2> /dev/null 
#touch $WORKDIR/failedProbes.txt 2> /dev/null 
#for error in $WORKDIR/publishedPids/*.error; do \
#    ERR=`basename $error | cut -d'.' -f1`
#   cat $WORKDIR/ffprobeFile/$ERR >> $WORKDIR/failedProbes.txt
#   echo "" >> $WORKDIR/failedProbes.txt
#done
