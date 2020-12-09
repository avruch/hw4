 #!/bin/bash 
# first we access the website to gather the relevent articles
wget https://www.ynetnews.com/category/3082 &> /dev/null

grep -o -E '(https://www.ynetnews.com/article/)([0-9]|[a-z]|[A-Z]){9}(")+' 3082\
	 | sort -u | sed 's/"//' > sorted.txt
#we have generated file sorted.txt which has a list of unique urls 
wc -l sorted.txt | sed s/sorted.txt// > results.csv

#now we run a while loop and open every single article to count the appearances
# of bibi and beni in text
while read line 
do
	wget -O temp.txt $line &> /dev/null

	bibi_count=$(grep -o 'Netanyahu' temp.txt | wc -l)
	beni_count=$(grep -o 'Gantz' temp.txt | wc -l)

	if   [[ "$bibi_count" == 0  &&  "$beni_count" == 0 ]]  ; then

	 	 echo "${line}, -" >> results.csv 

	else

		 echo "${line}, Netanyahu, ${bibi_count}, Gantz, ${beni_count}"\
		  >> results.csv
	fi
 
done < sorted.txt
#after program is done we remove the unncessary files created along the way
rm 3082	temp.txt sorted.txt	
