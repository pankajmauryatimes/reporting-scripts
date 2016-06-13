#!/bin/bash

set +x
export pth=`date +%d%b%y`

cd /home/dwhuser/generic_etl/wip

echo "Flat file moving..."
printf "Flat file moving..."
mv WIDGET_CREATE_FACT.txt WIDGET_CREATE_FACT.txt_$pth
mv WIDGET_UPDATE_FACT.txt WIDGET_UPDATE_FACT.txt_$pth
mv WIDGET_STATUS_MASTER.txt WIDGET_STATUS_MASTER.txt_$pth
mv WIDGET_MASTER.txt WIDGET_MASTER.txt_$pth
mv new_resume_profile_complete_fact.txt new_resume_profile_complete_fact.txt_$pth
mv edit_resume_profile_complete_fact.txt edit_resume_profile_complete_fact.txt_$pth
mv new_resume_profile_complete_widgets_dist_fact.txt new_resume_profile_complete_widgets_dist_fact.txt_$pth
mv edit_resume_profile_complete_widgets_dist_fact.txt edit_resume_profile_complete_widgets_dist_fact.txt_$pth

echo "File Ziping ..."
printf "File Ziping ..."
gzip /home/dwhuser/generic_etl/wip/WIDGET*
gzip /home/dwhuser/generic_etl/wip/edit_resume_profile_complete_fact.txt_$pth
gzip /home/dwhuser/generic_etl/wip/new_resume_profile_complete_fact.txt_$pth
gzip /home/dwhuser/generic_etl/wip/new_resume_profile_complete_widgets_dist_fact.txt_$pth
gzip /home/dwhuser/generic_etl/wip/edit_resume_profile_complete_widgets_dist_fact.txt_$pth

echo "File Archiving..."
printf "File Archiving..."
mv /home/dwhuser/generic_etl/wip/WIDGET*.gz /home/dwhuser/generic_etl/data_archive
mv /home/dwhuser/generic_etl/wip/new_resume_profile_complete_fact.txt_$pth.gz /home/dwhuser/generic_etl/data_archive
mv /home/dwhuser/generic_etl/wip/edit_resume_profile_complete_fact.txt_$pth.gz /home/dwhuser/generic_etl/data_archive
mv /home/dwhuser/generic_etl/wip/new_resume_profile_complete_widgets_dist_fact.txt_$pth.gz /home/dwhuser/generic_etl/data_archive
mv /home/dwhuser/generic_etl/wip/edit_resume_profile_complete_widgets_dist_fact.txt_$pth.gz /home/dwhuser/generic_etl/data_archive
rm -f /home/dwhuser/generic_etl/wip/widgets_stats_${pth}.done
exit
