#!/bin/bash
# Simple web crawler for finding RDF links on a website.
# $ bash crawlForLD.sh http://test.com.au 

rm urls.txt
rm sub-urls.txt
rm sub-2-urls.txt

site=$1

function visit(){
    test=0
    test=`echo $1 | grep -F -w $site`
    if [[ $test = $1 ]]
    then
    curl -silent $1 | grep href=\" | grep "http://" | grep -o "http:\/\/[^\"]*" >> $2
    fi
}

visit $site urls.txt

while read line
do
    visit $line sub-urls.txt
done < urls.txt

while read line
do
    visit $line sub-2-urls.txt
done < sub-urls.txt

grep ".rdf" urls.txt > seeds_test.txt
grep ".RDF" urls.txt > seeds_test.txt
grep ".rdf" sub-urls.txt > seeds_test.txt
grep ".RDF" sub-urls.txt > seeds_test.txt
grep ".rdf" sub-2-urls.txt > seeds_test.txt
grep ".RDF" sub-2-urls.txt > seeds_test.txt



