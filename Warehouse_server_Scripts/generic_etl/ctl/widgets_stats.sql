truncate table widget_master;
truncate table widget_status_master;
truncate table widget_create_fact;
truncate table widget_update_fact;
truncate table new_resume_profile_complete_fact;
truncate table edit_resume_profile_complete_fact;
truncate table edit_resume_profile_complete_widgets_dist_fact;
truncate table new_resume_profile_complete_widgets_dist_fact;
load data local infile '/home/dwhuser/generic_etl/wip/WIDGET_MASTER.txt' into table widget_master fields terminated by ',' enclosed by '"' lines terminated by '\n';
load data local infile '/home/dwhuser/generic_etl/wip/WIDGET_STATUS_MASTER.txt' into table widget_status_master fields terminated by ',' enclosed by '"' lines terminated by '\n';
load data local infile '/home/dwhuser/generic_etl/wip/WIDGET_CREATE_FACT.txt' into table  widget_create_fact fields terminated by ',' enclosed by '"' lines terminated by '\n';
load data local infile '/home/dwhuser/generic_etl/wip/WIDGET_UPDATE_FACT.txt' into table widget_update_fact fields terminated by ',' enclosed by '"' lines terminated by '\n';
load data local infile '/home/dwhuser/generic_etl/wip/new_resume_profile_complete_fact.txt' into table new_resume_profile_complete_fact fields terminated by ',' enclosed by '"' lines terminated by '\n';
load data local infile '/home/dwhuser/generic_etl/wip/edit_resume_profile_complete_fact.txt' into table edit_resume_profile_complete_fact fields terminated by ',' enclosed by '"' lines terminated by '\n';
load data local infile '/home/dwhuser/generic_etl/wip/edit_resume_profile_complete_widgets_dist_fact.txt' into table edit_resume_profile_complete_widgets_dist_fact fields terminated by ',' enclosed by '"' lines terminated by '\n';
load  data local infile '/home/dwhuser/generic_etl/wip/new_resume_profile_complete_widgets_dist_fact.txt' into table new_resume_profile_complete_widgets_dist_fact  fields terminated by ',' enclosed by '"' lines terminated by '\n';
