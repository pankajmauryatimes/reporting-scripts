#!/bin/bash

set +x
export pth=`date +%d%b%y`
mv /home/dwhuser/generic_etl/wip/LOGIN_USAGE_HISTORY.txt /home/dwhuser/generic_etl/data_archive/LOGIN_USAGE_HISTORY_${pth}.txt
mv /home/dwhuser/generic_etl/wip/LOGIN_USAGE_HISTORY_${pth}.txt /home/dwhuser/generic_etl/log
rm /home/dwhuser/generic_etl/wip/login_usage_history_${pth}.done
