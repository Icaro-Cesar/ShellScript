#!/bin/bash

if ["$1" == ""]
then
echo -e "\n This scripts need a object!\n\nExemple: 192.168.0\n"
else
echo -e "\n\n   -------- List of Hosts Up --------\n\n"
for hosts in {1..254};do
ping -c1 $1.$hosts | grep "64" | cut -d " " -f 4 | sed 's/.$//'
done
fi