#!/bin/sh
. ~dwhuser/.bash_profile

now=`date +%m%d%Y-%H%M%S`
printf "============================== Start SHELL script TJ_DWH_V2.ksh =============================================== \n "
date
/home/dwhuser/tjdwh/bin/TJ_DWH_V2.ksh > /home/dwhuser/tjdwh/log/TJ_DWH_V2_${now}.log
date
printf "============================== End SHELL script TJ_DWH_V2.ksh =============================================== \n "

#printf "============================== Cand Search Logs Start =============================================== \n "
#date
#/home/dwhuser/tjdwh/bin/cand_searchlogs.ksh > /home/dwhuser/tjdwh/log/cand_searchlogs_${now}.log
#date
#printf "=============================== Cand Search logs End ==================================================  \n"

#printf "============================== Start SHELL script load_sms_cand_logs.csh ==================================== \n "
#date
#/home/dwhuser/tjdwh/bin/load_sms_cand_logs.csh > /home/dwhuser/tjdwh/log/load_sms_cand_logs_${now}.log
#date
#printf "============================== End SHELL script load_sms_cand_logs.csh ======================================= \n "

printf "============================== Start SHELL script load_sovren_learning.csh ==================================== \n "
date
#/home/dwhuser/tjdwh/bin/load_sovren_learning.csh > /home/dwhuser/tjdwh/log/load_sovren_learning_${now}.log
date
printf "============================== End SHELL script load_sovren_learning.csh ======================================= \n "

#printf "============================== Corp Search Logs Start =============================================== \n "
#date
#/home/dwhuser/tjdwh/bin/corp_searchlogs.ksh > /home/dwhuser/tjdwh/log/corp_searchlogs_${now}.log
#date
#printf "=============================== Corp Search logs End ==================================================  \n"

printf "==============================Move Data Script 1 Start=============================================== \n "
date
#/home/dwhuser/tjdwh/bin/move_data_1.csh > /home/dwhuser/tjdwh/log/move_data_1_${now}.log
date
printf "==============================Move Data Script 1 End=============================================== \n "

printf "============================== Send Process Completion E-Mail =============================================== \n "
/home/dwhuser/tjdwh/bin/mail.pl T > /dev/null
date
printf "============================================================================================ \n"

printf "============================================================================================================== \n"
printf "\n End CORNTAB job for DAY: \n"
date


