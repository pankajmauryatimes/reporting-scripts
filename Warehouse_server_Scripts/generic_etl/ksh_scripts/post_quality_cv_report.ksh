#!/bin/bash

export pth=`date +%d%b%y`

cd /home/dwhuser/generic_etl/wip

#echo \"select distinct e.full_date as LoginCreat_Date, d.full_date as Resume_Post_Date,  b.ad_id as Resume_ID,  c.promotion_id as Promotion_ID,  group_concat(g.functional_area_desc) as Functional_Desc into outfile '/tmp/quality_cv_report_${pth}.csv' from  login_dimension a, resume_dimension b,  promotion_dimension c, date_dimension d,  date_dimension e, resume_fact f, functionalarea_dimension g where a.login_key = b.login_key and b.promotion_key = c.promotion_key and b.resumeposted_date = d.date_key and a.logincreate_date = e.date_key and b.resume_key = f.resume_key and f.fa_key = g.fa_key and (c.promotion_id like '17p%' or c.promotion_id like '25p%' or  c.promotion_id like '38p%' or c.promotion_id like '50p%' or c.promotion_id like '88p%') and b.net_status = 11 and b.resumeposted_date = ((select date_key from date_dimension where full_date = current_date) -1) group by e.full_date,  d.full_date,  b.ad_id,  c.promotion_id,  g.functional_area_desc ;\" > /home/dwhuser/generic_etl/wip/quality_cv_report_sql_${pth}.txt

echo "select distinct     e.full_date \"Login Create Date\",      d.full_date \"Resume Post Date\",      b.ad_id \"Resume ID\",      c.promotion_id \"Promotion ID\",      group_concat(g.functional_area_desc) \"Functional Desc\" from      login_dimension a, resume_dimension b,      promotion_dimension c, date_dimension d,      date_dimension e, resume_fact f, functionalarea_dimension g where a.login_key = b.login_key and         b.promotion_key = c.promotion_key and         b.resumeposted_date = d.date_key and         a.logincreate_date = e.date_key and         b.resume_key = f.resume_key and         f.fa_key = g.fa_key and         (c.promotion_id like '17p%' or c.promotion_id like '25p%' or c.promotion_id like '38p%' or c.promotion_id like '50p%'            or c.promotion_id like '88p%' or c.promotion_id like '117p%' or c.promotion_id like '130p%') and         b.net_status = 11 and         b.resumeposted_date = ((select date_key from date_dimension where full_date = current_date) -1) group by     e.full_date,      d.full_date,      b.ad_id,      c.promotion_id,      g.functional_area_desc INTO OUTFILE '/tmp/quality_cv_report_${pth}.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n'; " > /home/dwhuser/generic_etl/wip/quality_cv_report_sql_${pth}.txt
mysql -udwhuser -pdwhuser tjdwh_db < /home/dwhuser/generic_etl/wip/quality_cv_report_sql_${pth}.txt > /home/dwhuser/generic_etl/logs/quality_cv_report_sql_${pth}.log

mv /home/dwhuser/generic_etl/wip/quality_cv_report_sql_${pth}.txt /home/dwhuser/generic_etl/logs
cp /tmp/quality_cv_report_${pth}.csv /home/dwhuser/generic_etl/wip
cp /home/dwhuser/generic_etl/ksh_scripts/.quality_cv_ftp.ftp /home/dwhuser/generic_etl/wip/
chmod 755 /home/dwhuser/generic_etl/wip/.quality_cv_ftp.ftp
#echo `perl -pi -e '\/s\/\t\/\/g' quality_cv_report_${pth}.csv`
#echo `perl -pi -e '\/s\/\\N\/\/g' quality_cv_report_${pth}.csv`
/home/dwhuser/generic_etl/wip/.quality_cv_ftp.ftp > /home/dwhuser/generic_etl/logs/.quality_cv_ftp.log
mv /home/dwhuser/generic_etl/wip/quality_cv_report_${pth}.csv /home/dwhuser/generic_etl/data_archive
exit
