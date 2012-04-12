#!/bin/bash

WORKDIR=$1

LS="ls -l --time-style=long-iso"

function errorsAtStage {
	local STAGE=$1
	local ERRORS=`find $WORKDIR/${STAGE}_*/ -name *.error -maxdepth 1 2> /dev/null | wc -l`
	_RET=$ERRORS
}

function succesesAtStage {
	local STAGE=$1
	local SUCCES=`find $WORKDIR/${STAGE}_*/ -maxdepth 1 2> /dev/null | grep -v error| wc -l`
	_RET=$SUCCES
}


for i in {10..99}; do \
	dir=`ls -d $WORKDIR/${i}_* 2> /dev/null`
	if [ "$dir" == "" ]
	then 
		continue
	fi
	file=`basename $dir`
	echo "Stage $file"
	succesesAtStage $i
	echo "Total succes $_RET"
	errorsAtStage $i
	echo "Total errors $_RET"
	_RET=0
	echo
done

