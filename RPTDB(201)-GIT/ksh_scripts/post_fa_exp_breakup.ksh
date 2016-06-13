#!/usr/bin/ksh
set +x
export now=`date +%Y-%m-%d' '%H:%M:%S`
export tdate=`date +%Y-%m-%d`

perl -pi -e 's/"//g' ${LOG_DIR}/experience_breakup.txt
perl -pi -e 's/"//g' ${LOG_DIR}/fa_breakup.txt

cp ${LOG_DIR}/experience_breakup.txt ${LOG_DIR}/experience_range_application_breakup_${tdate}.txt
cp ${LOG_DIR}/fa_breakup.txt ${LOG_DIR}/fa_wise_application_breakup_${tdate}.txt

perl -pi -e 's/:/,/g' ${LOG_DIR}/experience_range_application_breakup_${tdate}.txt
perl -pi -e 's/:/,/g' ${LOG_DIR}/fa_wise_application_breakup_${tdate}.txt
perl -pi -e "s/^/${tdate},/g" ${LOG_DIR}/fa_wise_application_breakup_${tdate}.txt
perl -pi -e "s/^/${tdate},/g" ${LOG_DIR}/experience_range_application_breakup_${tdate}.txt

cd ${LOG_DIR}

ftp_file=${LOG_DIR}/${cur_proc}.ftp
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
echo "put experience_range_application_breakup_${tdate}.txt" >> $ftp_file
echo "put fa_wise_application_breakup_${tdate}.txt" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
ftp_file=${LOAD_DIR}/${cur_proc}.ftp
#execute FTP script
chmod 755 ${ftp_file}
.${ftp_file}

chmod 755 /home/datareq/generic_etl/logs/fa_exp_breakup.ftp
/home/datareq/generic_etl/logs/fa_exp_breakup.ftp

perl -pi -e 's/172.16.84.220/115.112.206.220/g' ${ftp_file}
${ftp_file}
perl -pi -e 's/172.16.84.220/115.112.206.220/g' /home/datareq/generic_etl/logs/fa_exp_breakup.ftp
/home/datareq/generic_etl/logs/fa_exp_breakup.ftp

echo "EXPERIENCE       NATIVE_RESUME_COUNTS   TRANSCRIBED_RESUME_COUNTS   TOTAL_RESUME_COUNTS" > ${LOG_DIR}/experience_breakup2.txt
echo "----------       -------------          -------------              -------------" >> ${LOG_DIR}/experience_breakup2.txt
cat ${LOG_DIR}/experience_breakup2.txt ${LOG_DIR}/experience_breakup.txt > ${LOG_DIR}/experience_breakup3.txt
mv ${LOG_DIR}/experience_breakup3.txt ${LOG_DIR}/experience_breakup.txt

echo "" > ${LOG_DIR}/fa_breakup2.txt
echo "" >> ${LOG_DIR}/fa_breakup2.txt
echo "FUNCTIONAL DESC  NATIVE_RESUME_COUNTS   TRANSCRIBED_RESUME_COUNTS   TOTAL_RESUME_COUNTS" >> ${LOG_DIR}/fa_breakup2.txt
echo "---------------  -------------          -------------              -------------" >> ${LOG_DIR}/fa_breakup2.txt
cat ${LOG_DIR}/fa_breakup2.txt ${LOG_DIR}/fa_breakup.txt > ${LOG_DIR}/fa_breakup3.txt
mv ${LOG_DIR}/fa_breakup3.txt ${LOG_DIR}/fa_breakup.txt

cat ${LOG_DIR}/experience_breakup.txt ${LOG_DIR}/fa_breakup.txt > ${LOG_DIR}/exp_fa_wise_breakup.txt
${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name -Time: $now"  ${LOG_DIR}/exp_fa_wise_breakup.txt

rm -f ${LOG_DIR}/exp_fa_wise_breakup.txt
rm -f ${LOG_DIR}/fa_breakup.txt
rm -f ${LOG_DIR}/experience_breakup.txt
#mv ${LOG_DIR}/experience_range_application_breakup_${tdate}.txt /home/datareq/generic_etl/data_archive/experience_range_application_breakup_${tdate}.txt
#mv ${LOG_DIR}/fa_wise_application_breakup_${tdate}.txt /home/datareq/generic_etl/data_archive/fa_wise_application_breakup_${tdate}.txt
rm -f ${LOG_DIR}/experience_breakup3.txt ${LOG_DIR}/experience_breakup2.txt
rm -f ${LOG_DIR}/fa_breakup3.txt ${LOG_DIR}/fa_breakup2.txt
exit 0

