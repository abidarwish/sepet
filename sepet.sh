#!/bin/bash
#script by Abi Darwish https://t.me/abidarwish

VERSIONNAME="Sepet v"
VERSIONNUMBER="1.0"
GREEN="\e[1;32m"
RED="\e[;31m"
WHITE="\e[1m"
NOCOLOR='\e[0m'
DICTIONARY="dictionary.txt"

function header() {
	echo -e ${GREEN}" ${VERSIONNAME}${VERSIONNUMBER}" ${NOCOLOR}
	echo -e " by ${WHITE}Abi Darwish${NOCOLOR}"
}

function translatorEngine() {
	while IFS= read -r LINE; do
		CHINESE_LANG=$(echo ${LINE} | awk -F= '{print $1}')
		ENGLISH_LANG=$(echo ${LINE} | awk -F= '{print $2}')
		sed -i "s/${CHINESE_LANG}/${ENGLISH_LANG}/" "${MCKP_SOURCE_CODE}"
	done <"${DICTIONARY}"
}

function translate() {
	clear
	header
	echo
	read -p " Source code filename: " MCKP_SOURCE_CODE
	[[ -z ${MCKP_SOURCE_CODE} ]] && translate
	echo -e -n " Translating..."
	rm -rf dictionary.txt
	wget -q -O dictionary.tmp "https://raw.githubusercontent.com/abidarwish/sepet/main/dictionary.txt"
	cat dictionary.tmp | sort | uniq >dictionary.txt
	translatorEngine 2>&1
	echo -e ${GREEN}"done"${NOCOLOR}
	echo
	exit 0
}

translate
