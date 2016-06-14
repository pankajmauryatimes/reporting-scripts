#!/bin/bash

HOME=/ndata-archive/DAILY-REPORT
export email=$HOME/generic_etl/ksh_scripts/email.pl
export cur_proc_name="CUSTOMER CARE and CRM ASSESSMENT DATA"
export todate=`date +%d%b%y`
export now=`date +%m%d%Y-%H%M%S`
export ip=115.112.206.142
export user=dwhuser
export pswd=dwhpass
export ftp_dir=/opt/dwhdata/niyati

cd $HOME/ASSESSMENT
touch $HOME/generic_etl/wip/lst_files.txt
touch $HOME/generic_etl/wip/files.csv
touch $HOME/generic_etl/wip/mv_lst.txt
for i in `ls`
do
   echo "put ${now}_${i}" >> $HOME/generic_etl/wip/lst_files.txt
   echo "${now}_${i} " >> $HOME/generic_etl/wip/files.csv
   mv $i $HOME/generic_etl/wip/${now}_${i}
   echo "mv ${now}_${i} $HOME/generic_etl/data_archive/" >> $HOME/generic_etl/wip/mv_lst.txt
done

cd $HOME/generic_etl/wip

rec_file=`cat files.csv | wc -l`
if [ $rec_file == 0 ]
then
 txt_body="Hi Sanjay,

There is no file found for SCP IMT Server for Niyati.


Thanks,
dbteam
"

$email files "sanjay.biswas@timesgroup.com" "sanjay.biswas@timesgroup.com" "$cur_proc_name" "$txt_body"  

exit
fi

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
echo "`cat lst_files.txt`" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}

zip files.zip files.csv
txt_body="Hi Niyati,

File has been uploaded on IMT Server 
for CRM and CUSTOMER CARE (email ids)
Files name are below:
`cat files.csv`



Thanks,
dbteam
"

$email files "niyati.verma@timesgroup.com" "neha.kardam@timesgroup.com,avishek.sarkar1@timesgroup.com,mohd.saquib@timesgroup.com,sanjay.biswas@timesgroup.com" "$cur_proc_name" "$txt_body"

echo "#!/bin/bash

" > directive_mv_lst.txt

cat directive_mv_lst.txt mv_lst.txt > mv_lst.sh
chmod 755 mv_lst.sh
./mv_lst.sh

mv files.zip ../data_archive/ 
rm -f lst_files.txt mv_lst.sh directive_mv_lst.txt files.csv mv_lst.sh mv_lst.txt scp_file.ftp


exit


