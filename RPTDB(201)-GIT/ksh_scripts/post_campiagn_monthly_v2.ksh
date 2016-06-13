#!/usr/bin/ksh

set +x

export pth=`date +%d%b%y`

export ftp_dir=/home/dwhuser/generic_etl/data_archive/
export cur_proc=campiagn_monthly
export LOAD_DIR=${HOME}/generic_etl/wip
#export ip=172.16.84.220
export user=dwhuser
export pswd=dwhuser


touch ${LOAD_DIR}/${cur_proc}_${pth}.done

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
echo "put exp_wise_stage_relaxation.txt" >> $ftp_file
echo "put location_wise_stage_relaxation.txt" >> $ftp_file
echo "put Aggregate_stage_wise_inorganic_count.txt" >> $ftp_file
echo "put exp_wise_stage_organic.txt" >> $ftp_file
echo "put location_wise_stage_organic.txt" >> $ftp_file
echo "put Aggregate_stage_wise_organic_count.txt" >> $ftp_file
echo "put exp_wise_stage_older_converts_count.txt" >> $ftp_file
echo "put ${cur_proc}_${pth}.done" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
ftp_file=${LOAD_DIR}/${cur_proc}.ftp
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}
printf "All Files are created successfully"
echo "All Files are created successfully"
