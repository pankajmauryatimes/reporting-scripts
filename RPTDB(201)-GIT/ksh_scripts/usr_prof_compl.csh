#!/bin/bash

db2 "connect to tjrptdb user tcuser using jobusr"
db2 "set current schema tcuser"

db2 "MERGE INTO temp_user_profile_completeness AS tupc  USING (SELECT rra.AD_ID,ua.LOGIN_ID,                (CASE WHEN ua.NET_STATUS = 20 AND rra.SAVED_RESUME_PATH IS NULL THEN 25 WHEN ua.NET_STATUS = 20 AND rra.SAVED_RESUME_PATH IS NOT NULL THEN 35 WHEN ua.NET_STATUS = 11 AND rra.SAVED_RESUME_PATH IS NULL THEN 46 WHEN ua.NET_STATUS = 11 AND rra.SAVED_RESUME_PATH IS NOT NULL THEN 56 ELSE 0 END) + coalesce((SELECT SUM(wm.WEIGHT) FROM USER_WIDGETS uw, TCADMIN.WIDGET_MASTER wm WHERE uw.RESUME_ID = rra.AD_ID AND uw.WIDGET_STATUS_ID = 3 AND wm.WIDGET_ID = uw.WIDGET_ID),0) AS PROFILE_COMPLETENESS         from USER u ,               USER_AD ua,               RCRT_RESUME_ADS rra          WHERE u.LAST_LOGIN_DATE between '2012-01-01' and '2012-01-01'            AND ua.LOGIN_ID = U.LOGIN_ID            AND rra.AD_ID = ua.AD_ID            AND rra.VIEW IN ('Y','y') ) AS cmp  ON (tupc.AD_ID = cmp.AD_ID)  WHEN MATCHED THEN    UPDATE SET       tupc.AD_ID = cmp.AD_ID,       tupc.LOGIN_ID = cmp.LOGIN_ID,       tupc.PROFILE_COMPLETENESS = cmp.PROFILE_COMPLETENESS  WHEN NOT MATCHED THEN    INSERT        (AD_ID,LOGIN_ID,PROFILE_COMPLETENESS)    VALUES(cmp.AD_ID,cmp.LOGIN_ID,cmp.PROFILE_COMPLETENESS)"

db2 "commit"
db2 "terminate"

