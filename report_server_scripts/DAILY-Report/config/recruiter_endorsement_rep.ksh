#!/usr/bin/ksh
set -x

export cur_proc=recruiter_endorsement_last_day
export cur_proc_name="Happy New Year Offer Report"
export pth=`date +%d%b%y`
export LOAD_DIR=/ndata-archive/DAILY-REPORT/${pth}/corp
export email=$HOME/generic_etl/ksh_scripts/email.pl
export tmail=vikasdeep.verma@timesgroup.com,avishek.sarkar1@timesgroup.com,rajendra.sanwal@timesgroup.com,sanjay.ravi@timesgroup.com,seema.mehndiratta@timesgroup.com
export cmail=sanjay.biswas@timesgroup.com,,patrick.joy@timesgroup.com
export cutoff=23:50:00
export remind=12:00:00
export remindsent=0
export rep_file=happy_new_year_offer_report
time=$(date +"%T")

while [[ $time < $cutoff ]]; do
   if [ -a ${LOAD_DIR}/${cur_proc}.txt ] 
   then
#-----------------------------------------	BEGIN PROCESS 	-------------------------
 
        cp -p ${LOAD_DIR}/${cur_proc}.txt $HOME/generic_etl/wip
	cd $HOME/generic_etl/wip

	if [ -r ${cur_proc}.txt ]
	then

	     echo "\"CAND_NAME\",\"CAND_MOBILE\",\"CAND_RESUME_ID\",\"POS_HIRED\",\"COM_HIRED\",\"LOC_HIRED\",\"CAND_LINKEDIN_URL\",\"REC_NAME\",\"REC_MOBILE\",\"LOGIN_ID\",\"STATUS\",\"CREATE_DATE\"" > header.txt
     	     cat header.txt ${cur_proc}.txt > ${rep_file}.csv
     	     rm -f header.txt
             rm -f ${cur_proc}.txt
        else
             echo "File is missing"
        fi
   zip ${rep_file}.zip ${rep_file}.csv

   txt_body="Hi All,

PFA the Happy New Year Offer Report from 1st Dec 2014 to till date.


Thanks,
BIDW Team
"

   $email ${rep_file} "${tmail}" "${cmail}" "${cur_proc_name}" "$txt_body"

   rm -f ${rep_file}.zip
   rm -f ${rep_file}.csv
   exit
#------------------------------------------- 	END PRCESS	-----------------------------------
   else
       	if [[ $time > $remind ]]
	then
	     if [ $remindsent -eq 0 ]
	     then
                 txt_body="Reminder Time is: $time 
                 $cur_proc_name - CAUTION: process is still waiting for the file(Server- 221)
                 TAKE CORRECTIVE ACTION IMMEDIATELY!!!"
                 touch dummy.txt
                 zip dummy.zip dummy.txt
                 $email "dummy" "${cmail}" "sanjay.biswas@timesgroup.com" "$cur_proc_name - WARNING"  "$txt_body"
		 remindsent=1
	     fi
	fi
        sleep 300   #wait 5 min before checking again
        time=$(date +"%T")
        printf "time is "$time
   fi
done

rm -f dummy.*
exit


