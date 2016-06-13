#!/usr/bin/ksh
set +x

mv /tmp/MEDIA_COMPANY_REVIEW_COUNT.txt /tmp/MEDIA_COMPANY_REVIEW_COUNT-${today}.txt
mv /tmp/MEDIA_COMPANY_USER_DATA.txt /tmp/MEDIA_COMPANY_USER_DATA-${today}.txt
mv /tmp/MEDIA_COMPANY_FOLLOWER_COUNT.txt /tmp/MEDIA_COMPANY_FOLLOWER_COUNT-${today}.txt

cp /tmp/MEDIA_COMPANY_REVIEW_COUNT-${today}.txt /home/datareq/generic_etl/data_archive/MEDIA_COMPANY_REVIEW_COUNT-${today}.txt
cp /tmp/MEDIA_COMPANY_USER_DATA-${today}.txt /home/datareq/generic_etl/data_archive/MEDIA_COMPANY_USER_DATA-${today}.txt
cp /tmp/MEDIA_COMPANY_FOLLOWER_COUNT-${today}.txt /home/datareq/generic_etl/data_archive/MEDIA_COMPANY_FOLLOWER_COUNT-${today}.txt

