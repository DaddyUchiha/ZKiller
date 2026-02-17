#!/bin/bash
      		
function subfinder(){
	dom=${1}
	if [[ -s "${dom}" ]]; then
		echo "[[+]]Directory already Exist"
		echo "[[+]]Output is Going Under it "
		command subfinder -d "${dom}" -o "${dom}" -v &>/dev/null
		#sort -u "${dom}/${dom}" -o "${dom}/domain-${dom}.txt"
        	echo "[[+]]Subdomain are saved in "${dom}""
        	echo "[[+]]Now Fuzzing Directories on ALL Subdomains::"
        	echo "[[+]]PLEASE WAIT::"
	elif	[[ ! -s "${dom}" ]]; then
		$(mkdir "${dom}")
		command subfinder -d "${dom}" -o "${dom}/${dom}" -v &>/dev/null
		#sort -u "${dom}/${dom}" -o "${dom}/${out}domain-${dom}.txt"
       		echo "[[+]]Subdomain are saved in domain-${dom}"
       		#echo "[[+]]Total Subdomain are found =>" $(wc -l "${dom}""/domain-""${dom}")
        	echo "[[+]]Now Fuzzing Directories on ALL Subdomains::"
        	echo "[[+]]PLEASE WAIT::"
        else
        	exit 1
        fi
        
}

function katana(){
	dom="${dom}/domain-${1}}"
	out="dir-${dom}.txt"
	echo "Finding Directories in all SUBDOMAINS"
	url=$(cat "${dom}/domain-${dom}.txt")
	if [[ ! -s ${url} ]]; then
		echo "[[-]] Subdomain File Error"
		echo "[[-]] Subdomains File maybe not present"
		exit 1
	fi
	while read url; do
		katana -list "${url}" -v -o "${out}"
	done

}
	exit 1

function alivesub(){
	dom="${1}"
	out="alive-${1}.txt"
	while read url; do
                cat ${dom} | httpx -mc 200 -sc | tee "$out"
        done

}

if [[ "${1}" == "-u" ]]; then
	domain="${2}"
	echo "Starting Enumeration on ${domain}"
        	subfinder ${domain} 
	echo "Now Starting Katana"
		katana ${domain}
else
        echo "Please Enter The Target URL!"
        exit 1
fi



