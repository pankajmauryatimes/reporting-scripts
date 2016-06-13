#!/bin/bash

set +x
nowd=`date +%m%d%Y`
${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - Report" $HOME/generic_etl/logs/${cur_proc}_${nowd}.log
exit 0
