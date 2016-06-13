#!/bin/bash

set +x

cd $HOME/generic_etl/wip/
ftp_dir=/home/datareq/promotion_data/data_files

rm -f $HOME/generic_etl/wip/promo_data_0_1_exp_f3.txt
rm -f $HOME/generic_etl/wip/promo_data_1_6_exp_f3.txt
rm -f $HOME/generic_etl/wip/promo_data_6above_exp_f3.txt

cp /tmp/promo_data_0_1_exp_f3_${ddate}.txt $HOME/generic_etl/wip/promo_data_0_1_exp_f3.txt
cp /tmp/promo_data_1_6_exp_f3_${ddate}.txt $HOME/generic_etl/wip/promo_data_1_6_exp_f3.txt
cp /tmp/promo_data_6above_exp_f3_${ddate}.txt $HOME/generic_etl/wip/promo_data_6above_exp_f3.txt


ftp_file=$HOME/generic_etl/wip/scp_file.ftp
echo "#!/bin/ksh" > $ftp_file
echo "HOST=$ip" >> $ftp_file
echo "USER=$user" >> $ftp_file
echo "PASSWD=$pswd" >> $ftp_file
echo "ftp -in \$HOST <<EOF" >> $ftp_file
echo "quote USER \$USER" >> $ftp_file
echo "quote PASS \$PASSWD" >> $ftp_file
echo "binary" >> $ftp_file
echo "cd $ftp_dir" >> $ftp_file
echo "pwd" >> $ftp_file
echo "mput *exp_f3*" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}

printf "StepAhead mailer data requirement has been refreshed" > $HOME/generic_etl/logs/dummy.txt
printf "for F3 " >> $HOME/generic_etl/logs/dummy.txt
${KSH_SCRIPTS_DIR}/mail $demail   "$cur_proc - Data has been Refreshed " $HOME/generic_etl/logs/dummy.txt

rm -f scp_file.ftp
rm -f $FILE_READY
