#!/bin/bash

set +x
export pth=`date +%d%b%y`
cd /home/dwhuser/generic_etl/wip
perl -pi -e 's/,,/,\\N,/g' mailer_report_*
rm -f /home/dwhuser/generic_etl/wip/${cur_proc}_${pth}.done
exit
