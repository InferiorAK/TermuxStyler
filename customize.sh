#! /usr/bin/env bash

: <<DOCUMENTATIONXX

  Author   : InferiorAK
  github   : github.com/InferiorAK
  facebook : facebook.com/InferiorAK
  Youtube  : youtube.com/@inferiorak
  Tool     : TermuxStyler
  Version: 1.0

  1st Release  21-04-2023

Termux is an Android terminal emulator and Linux environment app that works directly with no rooting or setup required. A minimal base system is installed automatically - additional packages are available using the APT package manager. This tool is for Styling Termux and Adding Shortcut Keys to it.

DOCUMENTATIONXX

RED=$'\e[31m'
GREEN=$'\e[32m'
YELLOW=$'\e[33m'
YELLOW_L=$'\e[93m'
NORMAL=$'\e[0m'


DIR="$HOME/.termux"
DIR_fish="$HOME/../usr/etc/fish/functions"

clear
# banner
banner(){
	if ! which lolcat > /dev/null
	then
		cat res/banner
	else
		cat res/banner | lolcat
	fi
}

# check & fix
check(){
	printf "# Compatibility...\n\n"
	if ! which lolcat > /dev/null
	then
		printf "\e[1;31m[\e[0m\e[1;77m+\e[0m\e[1;31m]\e[0m\e[1;77m ruby > \e[1;31m404\n"
		printf "\e[1;31m[\e[0m\e[1;77m+\e[0m\e[1;31m]\e[0m\e[1;77m lolcat > \e[1;31m404\n"
	else
		printf "\e[1;32m[\e[0m\e[1;77m+\e[0m\e[1;32m]\e[0m\e[1;77m ruby > \e[1;32mOK\n"
		printf "\e[1;32m[\e[0m\e[1;77m+\e[0m\e[1;32m]\e[0m\e[1;77m lolcat > \e[1;32mOK\n"
	fi
	
	if [ -d "${DIR}" ]
	then
		printf "\e[1;32m[\e[0m\e[1;77m+\e[0m\e[1;32m]\e[0m\e[1;77m .termux > \e[1;32mOK\n"
	else
		printf "\e[1;31m[\e[0m\e[1;77m+\e[0m\e[1;31m]\e[0m\e[1;77m .termux > \e[1;31m404\n"
		mkdir "$DIR"
		printf "\e[1;32m[\e[0m\e[1;77m+\e[0m\e[1;32m]\e[0m\e[1;77m fixed \n"
	fi
	
	if ! which fish > /dev/null
	then
		printf "\e[1;31m[\e[0m\e[1;77m+\e[0m\e[1;31m]\e[0m\e[1;77m Shell > \e[1;31m404\n"
		echo -e "${YELLOW_L}Insatlling Shell..."
		apt-get install fish -y > /dev/null 2>&1
		chsh -s fish
		printf "\e[1;32m[\e[0m\e[1;77m+\e[0m\e[1;32m]\e[0m\e[1;77m fixed \n"
	else
		chsh -s fish
		printf "\e[1;32m[\e[0m\e[1;77m+\e[0m\e[1;32m]\e[0m\e[1;77m Shell > \e[32mOK\n"
	fi
}

input(){
	printf "\n"
	read -p $'\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;32m Input your first name: \e[0m\e[1;96m\en' first
	read -p $'\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;32m Input your last name: \e[0m\e[1;96m\en' last
	read -p $'\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;32m Do you want to add Shortcut Keys?: [Y/N] \e[0m\e[1;96m\en' key
}

# Shell Customize
fish_func(){
	if [ -d "${DIR_fish}" ]
	then
		name_set
	else
		mkdir "${DIR_fish}"
		name_set
	fi
}
name_set(){
	if [[ $first == "" || $last == "" ]]
	then
		echo "${RED}Name Can't be Empty"
	else
		sed "s/Inferior/${first}/g" "res/fish_prompt.fish" > res/prompt.ak
		sed "s/AK/${last}/g" res/prompt.ak > "${DIR_fish}/fish_prompt.fish"
		rm -rf res/prompt.ak
	fi
}



# Color and Font
col_fnt(){
	if [ -f "${DIR}/font.ttf" ] || [  -f "{DIR}/colors.properties" ]
	then
		mv "$DIR/font.ttf" "$DIR/font.ttf.0" ; mv "${DIR}/colors.properties" "$DIR/colors.properties.0"
		cp res/font.ttf "$DIR"
		cp res/colors.properties "$DIR"
	else
		cp res/font.ttf "$DIR"
		cp res/colors.properties "$DIR"
	fi
}

# add keys
key(){
	if [[ $key =~ [yY] ]]
	then
		if [ -f "${DIR}/termux.properties" ]
		then
			mv "$DIR/termux.properties" "$DIR/termux.properties.0"
			cat res/keys.txt > "${DIR}/termux.properties"
		else
			touch "$DIR/termux.properties"
			cat res/keys.txt > "${DIR}/termux.properties"
		fi
	elif [[ $key =~ [nN] ]]
	then
		echo "Canceled"
	else
		echo "${RED}Invalid Input!"
	fi
}



# Implement
banner
check
input
fish_func
col_fnt
key
termux-reload-settings
xdg-open "https://youtube.com/@inferiorak"