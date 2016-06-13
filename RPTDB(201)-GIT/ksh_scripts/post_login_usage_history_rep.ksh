#!/usr/bin/ksh

set +x

cat total_logins_new_rep.csv > login_usage_history_rep.csv
cat unique_logins_new_rep.csv >> login_usage_history_rep.csv
cat total_applications_new_rep.csv >> login_usage_history_rep.csv
cat profile_update_new_rep.csv  >> login_usage_history_rep.csv
cat total_logins_old_rep.csv >> login_usage_history_rep.csv
cat unique_logins_old_rep.csv >> login_usage_history_rep.csv
cat total_applications_old_rep.csv >> login_usage_history_rep.csv
cat profile_update_old_rep.csv  >> login_usage_history_rep.csv

mv login_usage_history_rep.csv $LOAD_DIR/login_usage_history_rep_${todate}.csv

cd ${LOAD_DIR}

ftp_file=${LOAD_DIR}/${cur_proc}.ftp
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
echo "put ${cur_proc}_${todate}.csv" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
ftp_file=${LOAD_DIR}/${cur_proc}.ftp
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}

echo "All Files are created successfully"
touch $LOAD_DIR/${cur_proc}_${today}.done
