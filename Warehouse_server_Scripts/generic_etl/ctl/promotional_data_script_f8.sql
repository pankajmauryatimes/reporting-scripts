truncate temp_F8_ad_ids;
load data local infile 'promotional_F8_AD_ID.csv' into table temp_F8_ad_ids fields terminated by ',' enclosed by '"' lines terminated by '\n';
