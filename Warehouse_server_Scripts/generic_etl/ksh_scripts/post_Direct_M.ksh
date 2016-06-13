#!/bin/bash

set +x
rm /home/dwhuser/generic_etl/wip/Direct_M.csv
touch /home/dwhuser/generic_etl/job_complete/${cur_proc}_${FDAY}.done
