#!/bin/ksh

set +x

cd $HOME/generic_etl/wip/
ip=115.112.206.220
user=root
pswd=tooroot
ftp_dir=/tmp

del_file=/tmp/del_file_${today}.ftp
echo "#!/bin/ksh" > $del_file
echo "HOST=$ip" >> $del_file
echo "USER=$user" >> $del_file
echo "PASSWD=$pswd" >> $del_file
echo "ftp -in \$HOST <<EOF" >> $del_file
echo "quote USER \$USER" >> $del_file
echo "quote PASS \$PASSWD" >> $del_file
echo "binary" >> $del_file
echo "cd $ftp_dir" >> $del_file
echo "pwd" >> $del_file

for i in `cat /tmp/crm_lead_souce_file_${today}.txt`
do
   echo "del ${i}.txt" >> $del_file
done
echo "del crm_lead_souce_file_${today}.txt" >> $del_file
echo "del scp_file.ftp" >> $del_file
echo "quit" >> $del_file
echo "EOF" >> $del_file
#execute FTP script
chmod 755 ${del_file}
${del_file}

