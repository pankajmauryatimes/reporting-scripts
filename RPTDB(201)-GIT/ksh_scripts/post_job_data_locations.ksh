#!/usr/bin/ksh

today=`date +%d%b%y`

mv /home/datareq/generic_etl/wip/AP_job_data_$today.csv /home/datareq/generic_etl/data_archive/AP_job_data_$today.csv
mv /home/datareq/generic_etl/wip/Delhi_job_data_$today.csv /home/datareq/generic_etl/data_archive/Delhi_job_data_$today.csv
mv /home/datareq/generic_etl/wip/Gujrat_job_data_$today.csv /home/datareq/generic_etl/data_archive/Gujrat_job_data_$today.csv
mv /home/datareq/generic_etl/wip/Haryana_job_data_$today.csv /home/datareq/generic_etl/data_archive/Haryana_job_data_$today.csv
mv /home/datareq/generic_etl/wip/MP_job_data_$today.csv /home/datareq/generic_etl/data_archive/MP_job_data_$today.csv
mv /home/datareq/generic_etl/wip/Karnatka_job_data_$today.csv /home/datareq/generic_etl/data_archive/Karnatka_job_data_$today.csv
mv /home/datareq/generic_etl/wip/MH_job_data_$today.csv /home/datareq/generic_etl/data_archive/MH_job_data_$today.csv
mv /home/datareq/generic_etl/wip/Punjab_job_data_$today.csv /home/datareq/generic_etl/data_archive/Punjab_job_data_$today.csv
mv /home/datareq/generic_etl/wip/UP_job_data_$today.csv /home/datareq/generic_etl/data_archive/UP_job_data_$today.csv
mv /home/datareq/generic_etl/wip/TamilNadu_job_data_$today.csv /home/datareq/generic_etl/data_archive/TamilNadu_job_data_$today.csv
mv /home/datareq/generic_etl/wip/WB_job_data_$today.csv /home/datareq/generic_etl/data_archive/WB_job_data_$today.csv

scp /home/datareq/generic_etl/data_archive/AP_job_data_$today.csv root@115.112.206.86:/opt/Apache/htdocs/jobfeed/skmobi/Andhra_Pradesh
scp /home/datareq/generic_etl/data_archive/Delhi_job_data_$today.csv root@115.112.206.86:/opt/Apache/htdocs/jobfeed/skmobi/Delhi
scp /home/datareq/generic_etl/data_archive/Gujrat_job_data_$today.csv root@115.112.206.86:/opt/Apache/htdocs/jobfeed/skmobi/Gujrat
scp /home/datareq/generic_etl/data_archive/Haryana_job_data_$today.csv root@115.112.206.86:/opt/Apache/htdocs/jobfeed/skmobi/Haryana
scp /home/datareq/generic_etl/data_archive/MP_job_data_$today.csv root@115.112.206.86:/opt/Apache/htdocs/jobfeed/skmobi/Madhya_Pradesh
scp /home/datareq/generic_etl/data_archive/Karnatka_job_data_$today.csv root@115.112.206.86:/opt/Apache/htdocs/jobfeed/skmobi/Karnataka
scp /home/datareq/generic_etl/data_archive/MH_job_data_$today.csv root@115.112.206.86:/opt/Apache/htdocs/jobfeed/skmobi/Maharashtra
scp /home/datareq/generic_etl/data_archive/Punjab_job_data_$today.csv root@115.112.206.86:/opt/Apache/htdocs/jobfeed/skmobi/Panjab
scp /home/datareq/generic_etl/data_archive/UP_job_data_$today.csv root@115.112.206.86:/opt/Apache/htdocs/jobfeed/skmobi/Uttar_Pradesh
scp /home/datareq/generic_etl/data_archive/TamilNadu_job_data_$today.csv root@115.112.206.86:/opt/Apache/htdocs/jobfeed/skmobi/Tamil_Nadu
scp /home/datareq/generic_etl/data_archive/WB_job_data_$today.csv root@115.112.206.86:/opt/Apache/htdocs/jobfeed/skmobi/West_Bengal


exit 0
