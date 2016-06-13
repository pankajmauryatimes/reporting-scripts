#!/bin/bash

set +x

#today=`date +%d%b%y`
cd $HOME/generic_etl/wip/
mv $HOME/generic_etl/wip/job_alert_kpi.csv $HOME/generic_etl/data_archive/job_alert_kpi_${today}.csv
