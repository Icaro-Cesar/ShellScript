#!/bin/bash

####################################################################################
#										   #
#		Network Mapper							   #
#										   #
#	Autor: Ícaro César							   #
#	Version: 1.2								   #
#										   #
#	Goals: I want to make a network mapper, so I'm working in this script.	   #
#	If you want to help me, you will be welcome.				   #
#										   #
####################################################################################

sleep 2

echo -e "\n\n -------- Network Mapper --------\n\n"

if ["$1" == ""]
then
echo -e "\nYou must set a argument:\n"
echo -e "\n	Exemple $0 10.10.0.\n"

else

echo -e "\nScript to discovering hosts in that network $1 :\n"

for hosts in {1..254}; do

ping -c1 $1.$hosts | grep "64" | cut -d " " -f 4 | sed "s/.$//"

done
fi
