delete from tj_web_trend_data_stage;
load data local infile '/opt/external_source_data/webtrend_data/webtrend_141012.csv' into table tj_web_trend_data_stage fields terminated by ',' enclosed by '"' lines terminated by '\n';
