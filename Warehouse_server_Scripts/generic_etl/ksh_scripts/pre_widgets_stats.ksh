#!/bin/bash

set +x
export pth=`date +%d%b%y`

cd /home/dwhuser/generic_etl/wip
perl -pi -e 's/,,/,\\N,/g' WIDGET*
perl -pi -e 's/,,/,\\N,/g' new_resume_profile_complete_fact.txt 
perl -pi -e 's/,,/,\\N,/g' edit_resume_profile_complete_fact.txt
perl -pi -e 's/,,/,\\N,/g' new_resume_profile_complete_widgets_dist_fact.txt
perl -pi -e 's/,,/,\\N,/g' edit_resume_profile_complete_widgets_dist_fact.txt

