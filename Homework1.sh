
#!/bin/bash

#Licenciatura em Bioinformatica
#UC- Analise de Sequencias Biologicas
#HOMEWORK1
#Realizado por:
#Matilde Machado 202000174 Pedro Augusto 202000169
#Pedro Brito 202000074 Rodrigo Pinto 202000177


#Os dois argumentos que serao escritos pelo utilizador
database=$1
query=$2
function Search(){ #Esta metodo vai fornecer os dois links que precisamos para fazer o trabalho.
        linkIds="https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi/?db=$database&term=$query&retmax=100" #link para trabalhar com os IDs
        linkHistory=https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi\?db\=$database\&term\="$query"\&usehistory\=y\&retmax=100 #link para trabalhar com o historico
}
function getQkWe(){ #Este metodo utiliza o link historico para conseguir a "query key" e o numero "webenv" que serao precisos para o fetch.
	Search
        qKey=$(wget "$linkHistory" -O - |grep -i "<QueryKey>"|sed 's/<[^<>]*>//g'|sed 's/_*.//'|sed 's/M.*//'|rev |sed -r 's/(.{1}).*/\1/'|rev)
	#echo $QKey  > /home/mati/ASB/Homeworks/QueryKey
	webEnv=$(wget "$linkHistory" -O - |grep -i "<WebEnv>"|sed 's/<[^<>]*>//g'|sed 's/.*M/M/g')
	#echo $webEnv > /home/mati/ASB/Homeworks/WebEnv
	return
}
function FetchID(){ #Este metodo extra fornece o fasta atraves dos Ids tal como feito na aula.
	Search
	ids2=$(wget $link -O -|grep -i "^<Id>" | sed 's/[^0-9]//g' | tr "\n" "," |rev |cut -c 2- |rev)  #Lista de Ids
	wget https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi/\?db\=$database\&id\=$ids2\&rettype\=fasta -O ~/ASB/Homeworks/homework1.fasta
}
function FetchHistory(){ #Este ultimo metodo utiliza o metodo "getQkWe" e atraves da querykey e do Webenv consegue retorna o ficheiro fasta final do trabalho.
	getQkWe $database $query
	Fetch=$(wget https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi/\?db\=$database\&usehistory\=y\&query_key\=$qKey\&WebEnv\=$webEnv\&rettype\=fasta -O ~/ASB/Homeworks/FastaFinal.fasta)
	#echo $eFetch
	return }

FetchHistory $database



