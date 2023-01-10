#!/bin/bash
#script by Abi Darwish https://t.me/abidarwish

clear
echo -e -n " Installing..."
rm -rf dictionary.txt
wget -q "https://raw.githubusercontent.com/abidarwish/sepet/main/dictionary.txt"
rm -rf sepet
wget -q -O sepet "https://raw.githubusercontent.com/abidarwish/sepet/main/sepet.sh"
chmod 755 sepet
echo -e "done"
echo -e -n " Starting..."
sleep 2
sepet