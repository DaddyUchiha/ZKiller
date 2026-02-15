#!/bin/bash
      		
function subfinder(){
	dom=${1}
	out="sub-${dom}.txt"
	command subfinder -d "${dom}" -v &>/dev/null -o "${out}"
	if [[ ! -s "sub-${dom}.txt" ]]; then
		echo "[[-]] No Subdomain Found"
		exit 1
	fi
	
	sort -u "${out}" -o "domain-${dom}.txt"
       echo "Subdomain are saved in domain-https: sub-${dom}"
       echo "Now Fuzzing Directories on ALL Subdomains::"
       echo "PLEASE WAIT::"
}

function katana(){
	dom="${1}"
	out="${dom}.txt"
	echo "Finding Directories in all SUBDOMAINS"
	url=$(cat "domain-${dom}.txt")
	if [[ ! -s ${url} ]]; then
		echo "[[-]] Subdomain File Error"
		exit 1
	fi
	while read url; do
		katana -list "${url}" -v -o "${out}"
	done

}

function alivesub(){
	dom="${1}"
	out="alive-${1}.txt"
	while read url; do
                cat ${dom} | httpx -mc 200 -sc | tee "$out"
        done

}

if [[ "${1}" == "-u" && -n "${2}" ]]; then

	domain="${2}"

        echo "Starting Enumeration on ${domain}"
        	subfinder ${domain}
        if [[ $? -eq 0 ]]; then
        	katana ${domain}
        fi
	if [[ $? -eq 0 ]]; then
                alivesub ${domain}
        fi

else
        echo "No"
        exit 1
fi



