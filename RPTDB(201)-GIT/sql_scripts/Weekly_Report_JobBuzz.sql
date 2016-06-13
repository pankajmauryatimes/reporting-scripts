export to /tmp/MEDIA_COMPANY_REVIEW_COUNT.txt of del modified by coldel, datesiso select COMPANY_ID, count(0) from TCUSER.COMPANY_REVIEW where MODERATION_FLAG = 'N'  and COMPANY_ID in (select distinct COMPANY_ID from TCADMIN.COMPANY_MAST where INDUSTRYGRP_MAP_ID in (select distinct INDUSTRYGRP_MAP_ID from TCADMIN.INDUSTRY_SUBGRP_GROUP_MAP where INDUSTRY_SUBGROUP_ID = 200)) group by COMPANY_ID with ur

export to /tmp/MEDIA_COMPANY_FOLLOWER_COUNT.txt of del modified by coldel, datesiso select b.COMPANY_ID, count(distinct LOGIN_ID) from tcuser.FOLLOW_COMPANY a join TCADMIN.COMPANY_MAST b on a.FOLLOW_COMPANY_ID = b.COMPANY_ID where a.FLAG = '1'  AND b.COMPANY_ID in (select distinct COMPANY_ID from TCADMIN.COMPANY_MAST where INDUSTRYGRP_MAP_ID in (select distinct INDUSTRYGRP_MAP_ID from TCADMIN.INDUSTRY_SUBGRP_GROUP_MAP where INDUSTRY_SUBGROUP_ID = 200)) group by COMPANY_ID with ur

export to /tmp/MEDIA_COMPANY_USER_DATA.txt of del modified by coldel, datesiso select rev.COMPANY_ID, (select c.COMPANY_NAME from TCADMIN.COMPANY_MAST c where c.COMPANY_ID = rev.COMPANY_ID) as "COMPANY_NAME", rev.LOGIN_ID, rra.NAME, year(coalesce(rra.DOB, current_date)) AS "BIRTH_YEAR", case coalesce(rra.GENDER_ID, 0) when 0 then 'M' else 'F' end as "GENDER", (select le.GRAPEVINE_LEVEL_NAME from TCADMIN.RCRT_LEVEL_MAS le where rev.USER_LEVEL = le.LEVEL_ID) as "LEVEL", (select replace(replace(xml2clob(xmlagg(xmlelement(NAME a, (FM.FUNCTIONAL_NAME )))),'<A>',''),'</A>',', ') from tcadmin.RCRT_FUNCTIONAL_MAS FM where locate(trim(char(FM.FUNCTIONAL_ID)),rra.DESCRIPTION_COMMENT) <> 0) AS Functional_Area, (select LM.LOCATION_NAME from tcadmin.RCRT_LOCATION_MAS LM where LM.LOCATION_ID = rra.loc_city) AS Location, rra.work_exp as Resume_exp, rra.PRES_SALARY as Candidate_SALARY, (select max(rm.ROLE_DESC) from tcadmin.ROLE_MAS rm, tcuser.CANDIDATE_SELECTED_ROLES csr where int(substr(csr.ROLEMAP_ID,8,4)) = rm.ROLE_ID and rra.AD_ID= csr.AD_ID) as Resume_Role, rra.COMPANY1 as candidate_COMPANY1, rra.COMPANY2 as candidate_COMPANY2, upper(rev.COMPANY_RECOMMENDATION) as "RECOMMENDATION", rev.OVERALL_RATING, rev.COMPANY_RATING1, rev.COMPANY_RATING2, rev.COMPANY_RATING3, rev.COMPANY_RATING4, rev.COMPANY_RATING5,  rev.COMPANY_RATING6, rev.COMPANY_RATING7, rev.COMPANY_RATING8 from TCUSER.RCRT_RESUME_ADS rra, TCUSER.USER_AD ua, TCUSER.COMPANY_REVIEW rev where rra.AD_ID = ua.AD_ID  and ua.AD_ID = rev.AD_ID and ua.sub_cat_id = 2711 and rev.MODERATION_FLAG = 'N' and date(rev.ENTRY_DATE) > DATE(current_date) - 8 DAY and rev.COMPANY_ID in (select distinct COMPANY_ID from TCADMIN.COMPANY_MAST where INDUSTRYGRP_MAP_ID in (select distinct INDUSTRYGRP_MAP_ID from TCADMIN.INDUSTRY_SUBGRP_GROUP_MAP where INDUSTRY_SUBGROUP_ID = 200)) with ur
