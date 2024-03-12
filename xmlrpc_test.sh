#!/bin/bash
greenCol="\e[0;32m\033[1m"
endCol="\033[0m\e[0m"
redCol="\e[31m"
purpleCol="\e[0;35m\033[1m"
turquoiseCol="\e[0;36m\033[1m"

function usage(){
  echo -e "Usage: ${greenCol}$0 ${purpleCol}[ option ]"
  echo -e "\t -s [ Url ] "
  echo -e "\t -l [ Urls File ]${endCol}"
  exit 1
}

function list_urls(){
  if [ -f $list ]; then
    while read url
     do
      curl -s -X POST "$url/xmlrpc.php" -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0" -d "<methodCall><methodName>system.listMethods</methodName><params></params></methodCall>"| grep listMethods 2>&1 1>/dev/null && echo -e "[ ${redCol}VULNERABLE${endCol} ] - ${turquoiseCol}$url/xmlrpc.php${endCol}" || echo -e " [ ${greenCol}Not Vulnerable${endCol} ] - ${turquoiseCol}$url/xmlrpc.php${endCol}"
    done < $list
    exit 0
  else
    echo -e "${redCol}Urls file does not exist !!${endCol}"
    exit 1
  fi
}


function simple_url(){
   curl -s -X POST "$url/xmlrpc.php" -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0" -d "<methodCall><methodName>system.listMethods</methodName><params></params></methodCall>"| grep listMethods 2>&1 1>/dev/null && echo -e "[ ${redCol}VULNERABLE${endCol} ] - ${turquoiseCol}$url/xmlrpc.php${endCol}" || echo -e " [ ${greenCol}Not Vulnerable${endCol} ] - ${turquoiseCol}$url/xmlrpc.php${endCol}"
exit 0 
}

while getopts "s:l:" option; do
  case $option in
    s) url=$OPTARGS && url=$2 && simple_url;; 
    l) list=$OPTARGS && list=$2 && list_urls ;;
    *) usage;;
  esac
done

usage
