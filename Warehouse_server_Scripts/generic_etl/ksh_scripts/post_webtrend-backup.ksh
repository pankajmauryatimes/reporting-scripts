#!/bin/bash


echo "delete from tj_web_trend_data_stage;" > $HOME/generic_etl/wip/${cur_proc}_${today}.sql
echo "delete from tj_web_trend_data_stage2;" >> $HOME/generic_etl/wip/${cur_proc}_${today}.sql
echo "load data local infile '${LOAD_DIR}/$LOAD_FILE' into table tj_web_trend_data_stage fields terminated by ',' enclosed by '\"' lines terminated by '\n';" >> $HOME/generic_etl/wip/${cur_proc}_${today}.sql
echo "call prc_webtrend ();" >> $HOME/generic_etl/wip/${cur_proc}_${today}.sql
mysql -udwhuser -pdwhuser tjdwh_staging < $HOME/generic_etl/wip/${cur_proc}_${today}.sql? > $HOME/generic_etl/logs/${cur_proc}_${today}_sql.log
mv $HOME/generic_etl/wip/${cur_proc}_${today}.sql? $HOME/generic_etl/logs/${cur_proc}_${today}.sql?
