#!/bin/bash

##########################################################
#
# Name: range.sh
# Author: Ícaro César
# Version: 1.0
#
# Goals: Hello Friend. My goal with each script
# is to make it a command or program to be used on
# Linux at the end of its process. So I thank anyone
# who wants to make guesses.
#
#
##########################################################


if ["$1" == ""]
then
echo -e "\n This scripts need a object!\n\nExemple: 192.168.0\n"
else
echo -e "\n\n   -------- List of Hosts Up --------\n\n"
for hosts in {1..254};do
ping -c1 $1.$hosts | grep "64" | cut -d " " -f 4 | sed 's/.$//'
done
fi
