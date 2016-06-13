#!/bin/bash

export pth=`date +%d%b%y`

cd /home/dwhuser/generic_etl/wip

echo "select count(distinct login_key) into outfile '/tmp/fake_email_ids_cnt_${pth}.txt' from login_dimension where isFakeEmail = 1;" > /home/dwhuser/generic_etl/wip/fake_email_ids_cnt_sql_${pth}.txt
mysql -udwhuser -pdwhuser tjdwh_db < /home/dwhuser/generic_etl/wip/fake_email_ids_cnt_sql_${pth}.txt > /home/dwhuser/generic_etl/logs/fake_email_ids_cnt_sql_${pth}.log

mv /home/dwhuser/generic_etl/wip/fake_email_ids_cnt_sql_${pth}.txt /home/dwhuser/generic_etl/logs
cp /tmp/fake_email_ids_cnt_${pth}.txt /home/dwhuser/generic_etl/wip
cp /home/dwhuser/generic_etl/ksh_scripts/.fake_email_ids_cnt_ftp.ftp /home/dwhuser/generic_etl/wip/
chmod 755 /home/dwhuser/generic_etl/wip/.fake_email_ids_cnt_ftp.ftp
#echo `perl -pi -e '\/s\/\t\/\/g' quality_cv_report_${pth}.csv`
#echo `perl -pi -e '\/s\/\\N\/\/g' quality_cv_report_${pth}.csv`
/home/dwhuser/generic_etl/wip/.fake_email_ids_cnt_ftp.ftp > /home/dwhuser/generic_etl/logs/.fake_email_ids_cnt_ftp.log
mv /home/dwhuser/generic_etl/wip/fake_email_ids_cnt_${pth}.txt /home/dwhuser/generic_etl/data_archive
exit
