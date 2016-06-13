#!/bin/sh

#############################################################################
# Author 	:: Satendra Viswakarma
# Purpose	:: This script retireves data (adId) from provided Solr
#		:: server for privided criterion, like IT, Non-IT, active etc
#############################################################################

# Current Date  in YYYY-MM-DD format
tdate=`date +%Y-%m-%d`
ACT=`date -d '3 month ago'  +"%Y%m%d"`
YR0to2="0+TO+24"
YR2to99="24+TO+1188"
FRESHNESS="$ACT+TO+*"
DIR="/home/dwhuser/IT_NONIT/data"
IT="35+36+50+51+52+53+54+55+56+57+58+59+60+61+62+63+64+65+66+67+68+69+70+71+72+73+74+75+76"
NonIT="-1+10+11+12+13+14+15+16+17+18+19+-2+20+21+22+23+24+25+26+27+28+29+30+31+32+33+34+37+38+39+40+41+42+43+44+45+77+78+79+80+81+82+83+84+85+86"
#IP="192.168.207.211:8080"
IP="172.16.85.231:8080"
#IP="192.168.206.63:8080"


echo "FA:IT, Exp:0-2, Active "
#echo "http://$IP/Hire/resume/select/?q=*:*&start=0&rows=30000000&wt=csv&indent=on&fq=view:(Y)&fq=netstatus:(11+20)&fq=ExperienceMonth:\[$YR0to2\]&fq=logindate:\[$FRESHNESS\]&fq=FunctionAreaMas:($IT)&fl=adId"
curl "http://$IP/Hire/resume/select/?q=*:*&start=0&rows=30000000&wt=csv&indent=on&fq=view:(Y)&fq=netstatus:(11+20)&fq=ExperienceMonth:\[$YR0to2\]&fq=logindate:\[$FRESHNESS\]&fq=FunctionAreaMas:($IT)&fl=adId" > $DIR/3Month_IT_0-2Y.txt

echo "FA:Non IT, Exp:0-2, Active "
curl "http://$IP/Hire/resume/select/?q=*:*&start=0&rows=30000000&wt=csv&indent=on&fq=view:(Y)&fq=netstatus:(11+20)&fq=ExperienceMonth:\[$YR0to2\]&fq=logindate:\[$FRESHNESS\]&fq=FunctionAreaMas:($NonIT)&fl=adId" > $DIR/3Month_NonIT_0-2Y.txt

echo "FA:IT, Exp:2-99, Active "
curl "http://$IP/Hire/resume/select/?q=*:*&start=0&rows=30000000&wt=csv&indent=on&fq=view:(Y)&fq=netstatus:(11+20)&fq=ExperienceMonth:\[$YR2to99\]&fq=logindate:\[$FRESHNESS\]&fq=FunctionAreaMas:($IT)&fl=adId" > $DIR/3Month_IT_2-99Y.txt

echo "FA:Non IT, Exp:2-99, Active "
curl "http://$IP/Hire/resume/select/?q=*:*&start=0&rows=30000000&wt=csv&indent=on&fq=view:(Y)&fq=netstatus:(11+20)&fq=ExperienceMonth:\[$YR2to99\]&fq=logindate:\[$FRESHNESS\]&fq=FunctionAreaMas:($NonIT)&fl=adId" > $DIR/3Month_NonIT_2-99Y.txt

############################################################################################################################################

FRESHNESS="*+TO+$ACT"

echo "FA:IT, Exp:0-2, 4 Month+ "
#echo "http://$IP/Hire/resume/select/?q=*:*&start=0&rows=30000000&wt=csv&indent=on&fq=view:(Y)&fq=netstatus:(11+20)&fq=ExperienceMonth:\[$YR0to2\]&fq=logindate:\[$FRESHNESS\]&fq=FunctionAreaMas:($IT)&fl=adId"
curl "http://$IP/Hire/resume/select/?q=*:*&start=0&rows=30000000&wt=csv&indent=on&fq=view:(Y)&fq=netstatus:(11+20)&fq=ExperienceMonth:\[$YR0to2\]&fq=logindate:\[$FRESHNESS\]&fq=FunctionAreaMas:($IT)&fl=adId" > $DIR/4Month_IT_0-2Y.txt

echo "FA:Non IT, Exp:0-2, 4 Month+ "
curl "http://$IP/Hire/resume/select/?q=*:*&start=0&rows=30000000&wt=csv&indent=on&fq=view:(Y)&fq=netstatus:(11+20)&fq=ExperienceMonth:\[$YR0to2\]&fq=logindate:\[$FRESHNESS\]&fq=FunctionAreaMas:($NonIT)&fl=adId" > $DIR/4Month_NonIT_0-2Y.txt

echo "FA:IT, Exp:2-99, 4 Month+ "
curl "http://$IP/Hire/resume/select/?q=*:*&start=0&rows=30000000&wt=csv&indent=on&fq=view:(Y)&fq=netstatus:(11+20)&fq=ExperienceMonth:\[$YR2to99\]&fq=logindate:\[$FRESHNESS\]&fq=FunctionAreaMas:($IT)&fl=adId" > $DIR/4Month_IT_2-99Y.txt

echo "FA:Non IT, Exp:2-99, 4 Month+ "
curl "http://$IP/Hire/resume/select/?q=*:*&start=0&rows=30000000&wt=csv&indent=on&fq=view:(Y)&fq=netstatus:(11+20)&fq=ExperienceMonth:\[$YR2to99\]&fq=logindate:\[$FRESHNESS\]&fq=FunctionAreaMas:($NonIT)&fl=adId" > $DIR/4Month_NonIT_2-99Y.txt



