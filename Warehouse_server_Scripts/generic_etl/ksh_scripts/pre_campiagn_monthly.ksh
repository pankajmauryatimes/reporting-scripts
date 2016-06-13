#!/bin/bash

set +x
export yyyymm=`date --date="1 month ago" +%Y%m`

mv $HOME/generic_etl/data_archive/location_wise_stage_relaxation.txt $HOME/generic_etl/wip
mv $HOME/generic_etl/data_archive/location_wise_stage_organic.txt $HOME/generic_etl/wip
mv $HOME/generic_etl/data_archive/exp_wise_stage_relaxation.txt $HOME/generic_etl/wip
mv $HOME/generic_etl/data_archive/exp_wise_stage_organic.txt $HOME/generic_etl/wip
mv $HOME/generic_etl/data_archive/Aggregate_stage_wise_organic_count.txt $HOME/generic_etl/wip
mv $HOME/generic_etl/data_archive/Aggregate_stage_wise_inorganic_count.txt $HOME/generic_etl/wip
mv $HOME/generic_etl/data_archive/exp_wise_stage_older_converts_count.txt $HOME/generic_etl/wip

perl -pi -e "s/^/${yyyymm},/g" /home/dwhuser/generic_etl/wip/exp_wise_stage_relaxation.txt
perl -pi -e "s/^/${yyyymm},/g" /home/dwhuser/generic_etl/wip/location_wise_stage_relaxation.txt
perl -pi -e "s/^/${yyyymm},/g" /home/dwhuser/generic_etl/wip/Aggregate_stage_wise_inorganic_count.txt
perl -pi -e "s/^/${yyyymm},/g" /home/dwhuser/generic_etl/wip/exp_wise_stage_organic.txt
perl -pi -e "s/^/${yyyymm},/g" /home/dwhuser/generic_etl/wip/location_wise_stage_organic.txt
perl -pi -e "s/^/${yyyymm},/g" /home/dwhuser/generic_etl/wip/Aggregate_stage_wise_organic_count.txt
