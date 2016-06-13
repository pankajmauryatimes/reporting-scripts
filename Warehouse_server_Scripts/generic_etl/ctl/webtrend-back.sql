load data local infile '/opt/external_source_data/webtrend_data/${LOAD_DIR}/$LOAD_FILE' into table tj_web_trend_data_stage fields terminated by ',' enclosed by '\"' lines terminated by '\n';
