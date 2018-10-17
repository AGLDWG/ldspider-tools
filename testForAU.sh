#!/bin/bash
# Tests geolocation of a URL from a text file input during execution
# If URL is hosted in Australia or contains the .au ccTLD it remains
# in the file. All other URLs are removed from the file.

lnum=1
while IFS='' read -r line || [[ -n "$line" ]]; do
	dom=`echo $line | awk -F[/:] '{print $4}'`
	if [ -z "$dom" ]
	then
		dom="$line" 
	fi
	tld=`echo $dom | sed 's/.*\(...\)/\1/'`
	if [ "$tld" = ".au" ];
	then 
		echo "$line [Passed]"
	else
		ip=`dig +short $dom | tail -n1`
		loc=`curl -s ip.zxq.co/$ip?pretty=1 | grep '"country":'`
		country=`echo $loc | awk -F[\"] '{print $4}'`
		if [ "$country" = "AU" ];
		then	
			echo "$line [Passed]"
		else
			echo "$line [Failed]"
			sed -i "${lnum}d" ./"$1"
		fi
	fi
	lnum=$((lnum + 1))
done < "$1"

