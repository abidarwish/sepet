#!/bin/bash
#script by Abi Darwish https://t.me/abidarwish

VERSIONNAME="Sepet v"
VERSIONNUMBER="1.0"
GREEN="\e[1;32m"
RED="\e[;31m"
WHITE="\e[1m"
NOCOLOR='\e[0m'

function header() {
	echo -e ${GREEN}" ${VERSIONNAME}${VERSIONNUMBER}" ${NOCOLOR}
	echo -e " by ${WHITE}Abi Darwish${NOCOLOR}"
}

function translatorEngine() {
	while IFS= read -r LINE; do
		CHINESE_LANG=$(echo ${LINE} | awk -F= '{print $1}')
		ENGLISH_LANG=$(echo ${LINE} | awk -F= '{print $2}')
		sed -i "s/${CHINESE_LANG}/${ENGLISH_LANG}/" "/koolshare/webs/Module_merlinclash.asp"
	done <"dictionary.txt"
}

function translate() {
	clear
	header
	echo
	echo -e -n " Translating..."
	rm -rf dictionary.txt
	wget -q -O dictionary.tmp "https://raw.githubusercontent.com/abidarwish/sepet/main/dictionary.txt"
	cat dictionary.tmp | sort | uniq >dictionary.txt
	[[ ! -e /koolshare/webs/Module_merlinclash.asp.bak ]] && cp /koolshare/webs/Module_merlinclash.asp /koolshare/webs/Module_merlinclash.asp.bak
	translatorEngine 2>&1
	echo -e ${GREEN}"done"${NOCOLOR}
	echo
	exit 0
}

function restore() {
	clear
	header
	echo
	read -p " Do you want to restore MCKP back to the original Chinese?[y/n]: " RESTORE
	[[ ${RESTORE,,} != "y" ]] && translate
	echo -e -n " Restoring..."
	mv /koolshare/webs/Module_merlinclash.asp.bak /koolshare/webs/Module_merlinclash.asp
	sleep 3
	echo -e "${GREEN}done${NOCOLOR}"
	sleep 1
	echo
	exit 0
}

[[ ! -e /koolshare/webs/Module_merlinclash.asp.bak ]] && translate
restore
