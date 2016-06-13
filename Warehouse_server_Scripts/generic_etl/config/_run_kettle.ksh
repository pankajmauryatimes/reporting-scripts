#!/usr/bin/ksh
set -x
################################################################################
#    SCRIPT:_run_kettle.ksh
#   ARGUMENTS: MYSQL_USER SQL_FILE LOG_FILE ARG1 ARG2
#              -- ARG1 and ARG2 are optional arguments passed to sql script
#   PURPOSE: runs the MYSQL script 
################################################################################

USAGE="Usage: _run_kettle.ksh KETTLE REPOSITORY AND KETTLE JOBS "

if (( $# < 2 ))
then
  print "ERROR: Insufficient parameters supplied\n$USAGE"
  exit 1
fi

export KETTLE_REPO=$1
export KETTLE_JOB=$2
export ARG1=$3
nowd=`date +%m%d%Y`
#user_pass=`cat ${HOME}/generic_etl/config/.ora_secret | grep -i "^${DB2_DB}:" | grep -i ${DB2_USER} |cut -f3 -d:`
/opt/kettle/kitchen.sh -user=admin -pass=admin -rep=${KETTLE_REPO} -job=${KETTLE_JOB} > $HOME/generic_etl/logs/${KETTLE_JOB}_${nowd}.log
kettle_err1=`grep -i "Failure Mail" $HOME/generic_etl/logs/${KETTLE_JOB}_${nowd}.log|wc -l`
kettle_err=`grep -i "ERROR:"  $HOME/generic_etl/logs/${KETTLE_JOB}_${nowd}.log|wc -l`

if [[ $kettle_err -gt 0 ]] || [[ $kettle_err1 -gt 0 ]]
then
    exit 1
fi   

