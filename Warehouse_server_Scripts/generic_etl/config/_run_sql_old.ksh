#!/usr/bin/ksh
set -x
################################################################################
#    SCRIPT:_run_sql.ksh
#   ARGUMENTS: MYSQL_USER SQL_FILE LOG_FILE ARG1 ARG2
#              -- ARG1 and ARG2 are optional arguments passed to sql script
#   PURPOSE: runs the MYSQL script 
################################################################################

USAGE="Usage: _run_sql.ksh MYSQL_USER MYSQL_DB SQL_FILE LOG_FILE"

if (( $# < 4 ))
then
  print "ERROR: Insufficient parameters supplied\n$USAGE"
  exit 1
fi

export MYSQL_USER=$1
export MYSQL_DB=$2
export SQL_FILE=$3
export LOG_FILE=$4
export ARG1=$5
export ARG2=$6

user_pass=`cat ${HOME}/generic_etl/config/.ora_secret | grep -i "^${MYSQL_DB}:" | grep -i ${MYSQL_USER} |cut -f3 -d:`
now="date +%m%d%Y-%H%M%S"
mysql -u${MYSQL_USER} -p$user_pass $MYSQL_DB < $SQL_FILE > ${LOG_DIR}/$SQL_FILE_$nowd.log
exit $?
