 #!/bin/bash 

wget https://www.ynetnews.com/category/3082

grep -o -E '(https://www.ynetnews.com/article/)([0-9]|[a-z]|[A-Z]){9}(")+'3082|sort -u|sed 's/"//' >sorted.txt

wc -l sorted.txt| sed s/sorted.txt// >resuls.csv


while read line <sorted.txt
	wget -o temp.txt $line

	Netanyhu_counter=$(grep -o 'Netanyhu' temp.txt|wc -l)
	Gantz_counter=$(grep -o 'Gantz' temp.txt|wc -l)

	if   [[$"Netanyhu_counter" ==0]&&[$"Gantz_counter" ==0]]&& echo "${line}, -">>resuls.csv

	else 
		 echo "${line},Netanyhu,${Netanyhu_counter},Gantz,${Gantz_counter}">>resuls.csv
	fi
 
done

