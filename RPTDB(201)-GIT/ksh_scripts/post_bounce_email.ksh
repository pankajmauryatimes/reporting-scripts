#!/usr/bin/ksh

set +x

cd $HOME/generic_etl/wip/
rm -f $HOME/generic_etl/wip/bounce_email.ftp
export filename=bounce_ad_id_${lastday}.txt

mv bounce_ad_id.txt $filename 
perl -pi -e 's/\t/,/g' $filename
perl -pi -e 's/"//g' $filename

zip bounce_ad_id_${lastday}.zip bounce_ad_id_${lastday}.txt

txt_body="Hi Pravesh,

Please find AD_IDs in attached ZIP file, these all have bounce email..



Thanks,
dbteam
"

$mutt bounce_ad_id_${lastday}  "$tmail" "$cmail" "$cur_proc_name" "$txt_body"


#ftp_file=$HOME/generic_etl/wip/bounce_email.ftp
#echo "#!/bin/ksh" > $ftp_file
#echo "HOST=$ip" >> $ftp_file
#echo "USER=$user" >> $ftp_file
#echo "PASSWD=$pswd" >> $ftp_file
#echo "ftp -in \$HOST <<EOF" >> $ftp_file
#echo "quote USER \$USER" >> $ftp_file
#echo "quote PASS \$PASSWD" >> $ftp_file
#echo "binary" >> $ftp_file
#echo "cd $ftp_dir" >> $ftp_file
#echo "pwd" >> $ftp_file
#echo "put $filename" >> $ftp_file
#echo "quit" >> $ftp_file
#echo "EOF" >> $ftp_file
#execute FTP script
#chmod 755 ${ftp_file}
#${ftp_file}

mv $filename ../data_archive
rm -f /rptbackup/BOUNCE_EMAIL/toemail.txt
