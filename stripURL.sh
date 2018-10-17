#!/bin/bash
# Downloads the latest csv file of .au domains from ausdomainledger.net
# Strips the domains from the CSV and puts it into a text file aus-domains.txt

rm aus-domains.txt
rm au-domains-latest.csv.gz
rm au-domains-latest.csv

wget https://ausdomainledger.net/au-domains-latest.csv.gz
wait
gzip -d au-domains-latest.csv.gz
wait

while read line; do
	dom=`echo $line | awk -F, '{print $4}'`
	echo $dom >> aus-domains.txt
	echo $dom
done < au-domains-latest.csv

sort -u aus-domains.txt

