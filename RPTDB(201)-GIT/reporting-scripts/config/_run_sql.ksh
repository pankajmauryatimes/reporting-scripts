#!/usr/bin/ksh
set -x
################################################################################
#    SCRIPT:_run_sql.ksh
#   ARGUMENTS: MYSQL_USER SQL_FILE LOG_FILE ARG1 ARG2
#              -- ARG1 and ARG2 are optional arguments passed to sql script
#   PURPOSE: runs the MYSQL script 
################################################################################

USAGE="Usage: _run_sql.ksh DB2/MYSQL USER DB2/MYSQL DB SQL_FILE LOG_FILE"

if (( $# < 5 ))
then
  print "ERROR: Insufficient parameters supplied\n$USAGE"
  exit 1
fi

export USER=$1
export DB=$2
export SQL_FILE=$3
export LOG_FILE=$4
export DATABASE=$5
export ARG1=$6
export ARG2=$7

if [ "$DATABASE" == "DB2" ]; then
   if [ -f /candreports/db2inst2/sqllib/db2profile ]; then
        . /candreports/db2inst2/sqllib/db2profile
   fi
   user_pass=`cat ${HOME}/generic_etl/config/.ora_secret | grep -i "^${DB2_DB}:" | grep -i ${DB2_USER} |cut -f3 -d:`
   now="date +%m%d%Y-%H%M%S"

   db2 "connect to ${DB} user ${USER} using ${user_pass}"
   db2 "set current schema tcuser"

  db2 -svf $SQL_FILE > ${LOG_FILE}_sql

  db2 "commit"
  db2 "terminate"
else
  user_pass=`cat ${HOME}/generic_etl/config/.ora_secret | grep -i "^${MYSQL_DB}:" | grep -i ${MYSQL_USER} |cut -f3 -d:`
  now="date +%m%d%Y-%H%M%S"
  #mysql -u${USER} -p$user_pass $DB < $SQL_FILE > ${LOG_DIR}/$SQL_FILE_$nowd.log
  mysql -u${USER} -p$user_pass $DB < $SQL_FILE > ${LOG_FILE}_sql
fi
exit $?
