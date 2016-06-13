#!/bin/ksh

set +x

cd $HOME/generic_etl/wip

mv ${cur_proc}_${today}.csv $HOME/generic_etl/data_archive
rm -f ${cur_proc}_${pth}.done

