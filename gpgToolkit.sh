#!/bin/bash

RED='\033[1;31m'
NC='\033[0m'

export RED
export NC


if [[ $EUID -ne 0 ]]; then
	echo 
	echo -e "    ${RED}[!] Run as root [!]${NC}"
	exit
fi

f_main(){
clear
figlet 'GPG Toolkit'
echo ' by: c0v3rt'
echo "=================================================="
echo "    1. Generate key"
echo "    2. list keys"
echo "    3. encrypt text"
echo "    4. decrypt text"
echo "   99. exit"
echo "=================================================="
read -p "  > " OPTION

case $OPTION in
	1) gpg --full-generate-key;;
	2) gpg -k;;
	3) f_encrypt;;
	4) f_decrypt;;
	99) clear && exit;;
	*) echo 'Invalid input' && sleep 2;;
esac
}
export -f f_main

f_encrypt(){
echo '[removing - previous message]'
srm message
echo '[write message]'
sleep 2
vi message
echo '[list of key]'
gpg -k
read -p 'Select key : ' KEY
echo ''
echo ''
cat message | gpg -e --armor -r $KEY
echo ''
echo ''
srm message
}

export -f f_encrypt

f_decrypt(){
echo '[removing - previous message]'
srm message
echo '[paste message to decrypt]'
sleep 2
vi message
echo ''
echo ''
gpg -d message
echo ''
echo ''
srm message
}

export -f f_decrypt

while true; do f_main; done