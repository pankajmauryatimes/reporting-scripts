#!/bin/bash

set +x

mv $HOME/generic_etl/wip/location_wise_stage_relaxation.txt $HOME/generic_etl/data_archive/location_wise_stage_relaxation_${today}.txt
mv $HOME/generic_etl/wip/location_wise_stage_organic.txt $HOME/generic_etl/data_archive/location_wise_stage_organic_${today}.txt
mv $HOME/generic_etl/wip/exp_wise_stage_relaxation.txt $HOME/generic_etl/data_archive/exp_wise_stage_relaxation_${today}.txt
mv $HOME/generic_etl/wip/exp_wise_stage_organic.txt $HOME/generic_etl/data_archive/exp_wise_stage_organic_${today}.txt
mv $HOME/generic_etl/wip/Aggregate_stage_wise_organic_count.txt $HOME/generic_etl/data_archive/Aggregate_stage_wise_organic_count_${today}.txt
mv $HOME/generic_etl/wip/Aggregate_stage_wise_inorganic_count.txt $HOME/generic_etl/data_archive/Aggregate_stage_wise_inorganic_count_${today}.txt
mv $HOME/generic_etl/wip/exp_wise_stage_older_converts_count.txt $HOME/generic_etl/data_archive/exp_wise_stage_older_converts_count_${today}.txt

printf "Hi,\n"  > ${LOG_DIR}/dummy.log
chmod 777 ${LOG_DIR}/dummy.log
printf "\n" >> ${LOG_DIR}/dummy.log
printf "Older Conversion Data For Month `date +%B` below: \n" >> ${LOG_DIR}/dummy.log
printf "Exp Count \n" >> ${LOG_DIR}/dummy.log
printf "--- ----- \n" >> ${LOG_DIR}/dummy.log
cat $HOME/generic_etl/data_archive/exp_wise_stage_older_converts_count_${today}.txt >> ${LOG_DIR}/dummy.log
printf "\n" >> ${LOG_DIR}/dummy.log
printf "\n" >> ${LOG_DIR}/dummy.log
printf "Thanks,\n" >> ${LOG_DIR}/dummy.log
printf "Warehouse Server,\n" >> ${LOG_DIR}/dummy.log
${KSH_SCRIPTS_DIR}/mail $email   "$batch_proc_name - Older Conversion Data(`date +%B`)"  ${LOG_DIR}/dummy.log
echo "Mail Sent"
