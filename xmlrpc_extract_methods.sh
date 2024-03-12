#!/bin/bash
greenCol="\e[0;32m\033[1m"
endCol="\033[0m\e[0m"
redCol="\e[31m"
purpleCol="\e[0;35m\033[1m"
turquoiseCol="\e[0;36m\033[1m"

function usage(){
echo -e " Usage ${greenCol}$0${purpleCol} -u [ url-vulnerable ]${endCol}"
exit 1
}

function extractMethods(){
  echo -e "${greenCol}All Methods:${turquoiseCol}"      
  curl -s -X POST "$url/xmlrpc.php" -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0" -d "<methodCall><methodName>system.listMethods</methodName><params></params></methodCall>" | cut -d ">" -f 3 | cut -d "<" -f1 | sort -u 

  echo -e "${endCol}\n${greenCol}Useful methods:${endCol}"
  curl -s -X POST "$url/xmlrpc.php" -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0" -d "<methodCall><methodName>system.listMethods</methodName><params></params></methodCall>" | grep -oP --color "pingback.ping|system.multicall|wp.getUsersBlogs"
     exit 0
}

while getopts "u:" arg; do
  case $arg in
    u) url=$OPTARGS && url=$2 && extractMethods;;
    *) usage;;
  esac
done

usage

