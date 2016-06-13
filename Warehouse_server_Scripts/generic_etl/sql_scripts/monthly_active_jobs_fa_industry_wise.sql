select fd.functional_area_desc,T.job_count
      from (select  jf.function_key, count(distinct jd.job_key) as job_count
            from job_dimension jd,
                 job_fact jf
            where jd.date_posted_key <= DATE_FORMAT(date(now()), '%Y-%m-%d')
              and jd.date_expired_key > DATE_FORMAT(date(now()), '%Y-%m-%d')
              and jf.job_key = jd.job_key
           Group by jf.function_key
           ) T, functionalarea_dimension fd  
       where fd.fa_key = T.function_key INTO OUTFILE '/tmp/Monthly_ActiveJobs_FA_wise_distribution_01Jun16.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

select id.industry_desc,T.job_count
      from (select jf.industry_key, count(distinct jd.job_key) as job_count
            from job_dimension jd,
                 job_fact jf
            where jd.date_posted_key <= DATE_FORMAT(date(now()), '%Y-%m-%d')
              and jd.date_expired_key > DATE_FORMAT(date(now()), '%Y-%m-%d')
              and jf.job_key = jd.job_key
            Group by jf.industry_key
           )T, industry_dimension id 
      where T.industry_key = id.industry_key INTO OUTFILE '/tmp/Monthly_ActiveJobs_Industry_wise_distribution_01Jun16.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
