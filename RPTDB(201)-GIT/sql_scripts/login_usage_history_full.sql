export to /home/datareq/generic_etl/data_files/LOGIN_USAGE_HISTORY.txt of del modified by coldel, datesiso select cast(LOGIN_TIME as DATE) LOGIN_DATE, LOGIN_TYPE, VISIT_SOURCE, count(ID) as LOGIN_COUNT from TCUSER.LOGIN_USAGE_HISTORY group by cast(LOGIN_TIME as DATE) , LOGIN_TYPE, VISIT_SOURCE for fetch only with ur 

