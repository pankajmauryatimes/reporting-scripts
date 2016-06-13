#!/bin/bash

set +x
export pth=`date +%d%b%y`
cd /home/dwhuser/generic_etl/wip
mv lead_capture_detail_${todate}.txt lead_capture_detail.txt
perl -pi -e 's/,,/,\\N,/g' lead_capture_detail.txt
rm -f /home/dwhuser/generic_etl/wip/${cur_proc}_${todate}.done
exit
