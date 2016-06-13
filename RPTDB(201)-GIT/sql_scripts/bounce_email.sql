export to /home/datareq/generic_etl/wip/bounce_ad_id.txt of del modified by coldel, datesiso select ua.AD_ID from USER u,USER_AD ua, TEST_BOUNCE tb where tb.EMAIL_ID = u.EMAIL2   and ua.LOGIN_SRL_NO = u.LOGIN_SRL_NO   and ua.SUB_CAT_ID = 2711 with ur 

