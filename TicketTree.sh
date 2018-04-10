#!/bin/bash

#This script will create a folder baseLocation/Year/Month/6digitTicketnumber if the ticket folder is not created in last three months.
# Please define bash as per your preference. I think i tested it in CentOS and MAC as well.

base="/home/nikhil/tmp/"

i=1
while [ $i -lt 4 ]
do

        echo "Ticket No:"
        read t1
        T=$(echo "$t1" |tr -d '[:space:]' | grep -E -o  "[[:digit:]]{6}$")

        echo "$T"
        if [[ ! -z "$T" ]]; then
                break
        elif [[ -z "$T"  &&  $i -eq 1 ]]; then
                echo -e "\nCan't find 6 digit ticket in your input.Try once more"
                i=$[$i+1]
        elif [[ -z "$T"  &&  $i -eq 2 ]] ; then
                echo -e "\nCan't find 6 digit ticket in string. Press 'Enter' to exit"
                read tmp
                exit;
        fi
done

cd $base
m=`date +%Y/%m`
mb1=`date +%Y/%m  --date='-1 month'`
mb2=`date +%Y/%m  --date='-2 month'`
#echo "$m $mb1 $mb2"
loc=`find $m $mb1 $mb2 -name $T -type d`
#echo $loc
if [[ -z "$loc" ]]; then
        mkdir -p "$m""$T"
        loc="$m""$T"
fi

find $m $mb1 $mb2 -name $T -type d -print0 | while read -d $'\0' loc1 ; do
#       echo "$base""$loc1"
        cd "$base""$loc1"
		open .
        echo `pwd` | pbcopy
done

echo "Program completed!"
