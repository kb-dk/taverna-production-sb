#!/bin/bash

TAVERNA_DIR=$1

THIS_FOLDER=`dirname $(readlink -f $0)`
#echo $THIS_FOLDER

TAVERNA_OPTS="-cmdir $THIS_FOLDER/security/ -outputdir $THIS_FOLDER/fileIngest -embedded"
#echo $TAVERNA_OPTS

TAVERNA_INPUT="-inputvalue configFile $THIS_FOLDER/tavernaTestProperties.properties -inputvalue fileList $THIS_FOLDER/files.txt"
#echo $TAVERNA_INPUT

EXECUTE="$TAVERNA_DIR/executeworkflow.sh $THIS_FOLDER/fileIngestWorkflow.t2flow  $TAVERNA_OPTS $TAVERNA_INPUT"
echo $EXECUTE
exec $EXECUTE


