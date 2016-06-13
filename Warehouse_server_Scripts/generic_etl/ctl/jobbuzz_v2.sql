delete from JB_KPI_FACT;

load data local infile '/home/dwhuser/generic_etl/wip/JB_KPI_FACT.txt' into table JB_KPI_FACT fields terminated by ',' enclosed by '"' lines terminated by '\n';
