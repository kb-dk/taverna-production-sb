#!/bin/bash

WORKDIR=$1
MAX=$2
for ((number=1; number <= $MAX; number++)); do

	for i in {11..99}; do 
		dir=`ls -d $WORKDIR/${i}_* 2> /dev/null`
		if [ "$dir" == "" ]
		then 
			continue
		fi
		stage=`basename $dir`
		if [ -e $dir/$number.error ];
		then
			echo $number $stage
			break
		fi;
	done
done

#rm $WORKDIR/failedProbes.txt 2> /dev/null 
#touch $WORKDIR/failedProbes.txt 2> /dev/null 
#for error in $WORKDIR/publishedPids/*.error; do \
#    ERR=`basename $error | cut -d'.' -f1`
#   cat $WORKDIR/ffprobeFile/$ERR >> $WORKDIR/failedProbes.txt
#   echo "" >> $WORKDIR/failedProbes.txt
#done
