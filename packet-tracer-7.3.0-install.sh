#!/bin/bash

#######################################################################################
#
#		Script to Install Packet Tracer 7.3
#
#	Autor: Ícaro César
#
#	Description: This script fix the dependences issues of the Packet Tracer and
#	install the application. Any questions, contact my email:
#	icarocesar630@gmail.com
#
#######################################################################################

pt_check() {
	if [ ! $(ls | grep PacketTracer*.deb | head -n 1) ]; then
		printf "\nPacket Tracer install package (.deb) was not in that folder. Move it in the folder with this installer (.deb) before execute again.\n"
	   exit
	fi
}

get_dep() {
	for ((i=0; i<${#mirrors_list[*]}; i++)); do
		echo "Taking the ${mirrors_list[i]} ..."
		wget -q ${mirrors_list[i]}
	done
}

install_deps() {
	if [ $(ls ./  | grep "$1") ]; then
		echo "installing $1 ..."
		ls ./ | grep $1 | xargs -I "PACKAGE" apt-get -qy --allow-downgrades install ./"PACKAGE" >> /dev/null
	else
		if [ ! $(ls /bin | grep $1) ]; then
			echo "installing $1 ..."
			apt-get -qy install $1 >> /dev/null
		fi
	fi
}

install_packet-tracer() {
	printf "\n\nInstall Packet Tracer 7.3.0 ...\n"
	dpkg -i $(ls | grep PacketTracer*.deb | head -n 1)
}

clean() {
	printf "\nClean all dependences after install ...\n"
	for ((i=0; i<${#dependencies[*]}; i++)); do
		if [ $(ls ./  | grep ${dependencies[i]}) ]; then
			echo "Removing ${dependencies[i]} ..."
			rm $(ls ./  | grep ${dependencies[i]})
		fi
	done
}

check_install() {
	if [ $(ls /opt/pt/ | grep packettracer) ]; then
		printf "\nInstallation is complete. Let's go learn Networking with Packet Tracer 7.3.0!\n"
	else
		printf "\nSomething went wrong during the installation and the program was not installed. Sorry, that's life :) !\n"
	fi
}


dependencies=(
	wget
	libnss3
	libxslt1.1
	libqt5webkit5
	libdouble-conversion1
	qt-at-spi
	libjpeg-turbo8
	libicu60
	libssl1.0.0
)

mirrors_list=(
	http://mirrors.kernel.org/ubuntu/pool/main/d/double-conversion/libdouble-conversion1_2.0.1-4ubuntu1_amd64.deb
	http://mirrors.kernel.org/ubuntu/pool/main/q/qt-at-spi/qt-at-spi_0.4.0-3_amd64.deb
	http://mirrors.kernel.org/ubuntu/pool/main/libj/libjpeg-turbo/libjpeg-turbo8_2.0.3-0ubuntu1_amd64.deb
	http://mirrors.kernel.org/ubuntu/pool/main/i/icu/libicu60_60.2-3ubuntu3_amd64.deb
	http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.0.0_1.0.2g-1ubuntu4.15_amd64.deb
)

if [ `whoami` != root ]; then
	sleep 1
    echo "Please, execute this script as root or using sudo."
    sleep 1
	exit
fi

echo -n "\n\n ------- Install Packet Tracer 7 ------\n\n"
sleep 2

printf "\nVisit the following link and download Packet Tracer for Linux:
\n          https://www.netacad.com/         \n
Place it in the folder where you are running this installer before continuing.\n"
printf "\nContinue to Install? "
read -p "[Y/N] " readyToInstall

case $readyToInstall in
   [yY]* )
	   pt_check
	   get_dep
		 for ((i=0; i<${#dependencies[*]}; i++)); do
			 install_dep ${dependencies[i]}
		 done
	   install_packet-tracer
	   clean
	   check_install
		 ;;
   [nN]* ) exit;;
   * ) exit;;
esac
