#!/bin/bash

set +x

cd $HOME/generic_etl/wip
mv deleted_account_list_EWD_${todate}.txt $HOME/generic_etl/data_archive/EDW_Update-${today}.txt
rm -f /home/dwhuser/generic_etl/wip/${cur_proc}_${pth}.done
exit
