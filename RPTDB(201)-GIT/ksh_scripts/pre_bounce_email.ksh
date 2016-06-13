#!/usr/bin/ksh

set +x


if [ -r /rptbackup/ADHOC_BOUNCE_EMAIL/${lastday}_toemail.txt ]
then
    mv /rptbackup/ADHOC_BOUNCE_EMAIL/${lastday}_toemail.txt  /rptbackup/BOUNCE_EMAIL/adhoctoemail.txt
    mv /rptbackup/BOUNCE_EMAIL/${lastday}_toemail.txt /rptbackup/BOUNCE_EMAIL/regtoemail.txt
    cat /rptbackup/BOUNCE_EMAIL/adhoctoemail.txt /rptbackup/BOUNCE_EMAIL/regtoemail.txt > /rptbackup/BOUNCE_EMAIL/toemail.txt
else
mv /rptbackup/BOUNCE_EMAIL/${lastday}_toemail.txt /rptbackup/BOUNCE_EMAIL/toemail.txt 
fi

