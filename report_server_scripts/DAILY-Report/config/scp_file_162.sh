#!/bin/ksh

HOME=/ndata-archive/DAILY-REPORT
cd $HOME/generic_etl/wip
export ip=115.112.206.162
export user=root
export pswd=tooroot
export ftp_dir=/opt

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
echo "get $1" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}

echo "SCP File :$1"
exit_code=$?
echo "Exit Code = $exit_code"
if [ -a $HOME/generic_etl/wip/$1 ]
then
   echo "File Found"
else
   echo "File Not Fount Please Put Password"
   scp $1 root@115.112.206.162:/opt .
fi


