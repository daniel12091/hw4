#!/bin/bash
wget -qO-  https://www.ynetnews.com/category/3082|\
grep -o 'https://www.ynetnews.com/article/........."' | sort | uniq |\
sed 's/"//g' > temp.txt
cat temp.txt |\
while read line; do
    wget -qO- $line | grep -o Netanyahu |wc -w > neta.txt ;
    wget -qO- $line | grep -o Gantz | wc -w > gantz.txt;
    (echo $line ; echo ", Netanyahu, "; cat neta.txt; echo ", Gantz, "; cat gantz.txt)|\
    tr -d "\n"  >> temp2.txt
    echo >>temp2.txt
done
sed -i 's/Netanyahu, 0, Gantz, 0/-/g' temp2.txt
awk -v x=$(wc -l < "temp2.txt") 'NR==1{print x} 1' temp2.txt > results.csv
rm neta.txt gantz.txt temp.txt 

