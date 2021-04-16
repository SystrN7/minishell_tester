# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    tester.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: felix <felix@student.42lyon.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/26 14:54:17 by fgalaup           #+#    #+#              #
#    Updated: 2021/04/16 11:25:37 by felix            ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

# CONFIGURATION

export TESTED_SHELL_DIR="../"
export TESTED_SHELL_NAME="minishell"

export TESTED_SHELL=$TESTED_SHELL_DIR$TESTED_SHELL_NAME
export REFERENCE_SHELL=/bin/bash

# TODO : Add individual function test.
# TODO : Add sandbox for timeout.

# Reset
export Color_Off='\033[0m'       # Text Reset

# Regular Colors
export Black='\033[0;30m'        # Black
export Red='\033[0;31m'          # Red
export Green='\033[0;32m'        # Green
export Yellow='\033[0;33m'       # Yellow
export Blue='\033[0;34m'         # Blue
export Purple='\033[0;35m'       # Purple
export Cyan='\033[0;36m'         # Cyan
export White='\033[0;37m'        # White

# Bold
export BBlack='\033[1;30m'       # Black
export BRed='\033[1;31m'         # Red
export BGreen='\033[1;32m'       # Green
export BYellow='\033[1;33m'      # Yellow
export BBlue='\033[1;34m'        # Blue
export BPurple='\033[1;35m'      # Purple
export BCyan='\033[1;36m'        # Cyan
export BWhite='\033[1;37m'       # White

# Underline
export UBlack='\033[4;30m'       # Black
export URed='\033[4;31m'         # Red
export UGreen='\033[4;32m'       # Green
export UYellow='\033[4;33m'      # Yellow
export UBlue='\033[4;34m'        # Blue
export UPurple='\033[4;35m'      # Purple
export UCyan='\033[4;36m'        # Cyan
export UWhite='\033[4;37m'       # White

# Background
export On_Black='\033[40m'       # Black
export On_Red='\033[41m'         # Red
export On_Green='\033[42m'       # Green
export On_Yellow='\033[43m'      # Yellow
export On_Blue='\033[44m'        # Blue
export On_Purple='\033[45m'      # Purple
export On_Cyan='\033[46m'        # Cyan
export On_White='\033[47m'       # White

# High Intensity
export IBlack='\033[0;90m'       # Black
export IRed='\033[0;91m'         # Red
export IGreen='\033[0;92m'       # Green
export IYellow='\033[0;93m'      # Yellow
export IBlue='\033[0;94m'        # Blue
export IPurple='\033[0;95m'      # Purple
export ICyan='\033[0;96m'        # Cyan
export IWhite='\033[0;97m'       # White

# Bold High Intensity
export BIBlack='\033[1;90m'      # Black
export BIRed='\033[1;91m'        # Red
export BIGreen='\033[1;92m'      # Green
export BIYellow='\033[1;93m'     # Yellow
export BIBlue='\033[1;94m'       # Blue
export BIPurple='\033[1;95m'     # Purple
export BICyan='\033[1;96m'       # Cyan
export BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
export On_IBlack='\033[0;100m'   # Black
export On_IRed='\033[0;101m'     # Red
export On_IGreen='\033[0;102m'   # Green
export On_IYellow='\033[0;103m'  # Yellow
export On_IBlue='\033[0;104m'    # Blue
export On_IPurple='\033[0;105m'  # Purple
export On_ICyan='\033[0;106m'    # Cyan
export On_IWhite='\033[0;107m'   # White


function show_header ()
{
	# echo " ██████   ██████ █████ ██████   █████ █████  █████████  █████   █████ ██████████ █████       █████      "
	# echo "  ██████ ██████   ███   ██████   ███   ███  ███     ███  ███     ███   ███     █  ███         ███       "
	# echo "  ███ █████ ███   ███   ███ ███  ███   ███  ███          ███     ███   ███  █     ███         ███       "
	# echo "  ███  ███  ███   ███   ███  ███ ███   ███   █████████   ███████████   ██████     ███         ███       "
	# echo "  ███       ███   ███   ███   ██████   ███          ███  ███     ███   ███  █     ███         ███       "
	# echo "  ███       ███   ███   ███    █████   ███  ███     ███  ███     ███   ███     █  ███      █  ███      █"
	# echo " █████     █████ █████ █████    █████ █████  █████████  █████   █████ ██████████ ███████████ ███████████"
	cat head.color;
	echo " Made by fgalaup.                                                                               ╔╦╗╔═╗╔═╗╔╦╗╔═╗╦═╗"
	echo "                                                                                                 ║ ║╣ ╚═╗ ║ ║╣ ╠╦╝"
	echo "                                                                                                 ╩ ╚═╝╚═╝ ╩ ╚═╝╩╚═"
}

function show_summary ()
{
	TEST_FAILD=(cat ./temps/faild)
	if [ "$TEST_FAILD" = "0" ] 
	then
		echo $White $On_Green "TESTS PASS" $Color_Off
	else
		echo $White $On_Red "TEST(S) FAILD" $Color_Off
		echo "For more information you can look result.log"
	fi
	
	echo "TEST RESULT :"
	echo "\t- Test failds : " $(cat ./temps/faild)
	echo "\t- Test succes : " $(cat ./temps/succes)
}


function test_case ()
{
	# cat $0 | $TESTED_SHELL &> temps/tested;
	cat $0 | ./bash &> temps/tested;
	echo "Return code of :" $? >> temps/tested;

	cat $0 | $REFERENCE_SHELL &> temps/reference;
	echo "Return code of :" $? >> temps/reference;
	REFERENCE_STATUS_CODE=$?

	# return diff
	diff -U 3 temps/reference temps/tested > temps/diff
	DIFF_STATUS=$?

	if [ $DIFF_STATUS != 0 ]
	then
		printf "$Red KO $Color_Off"
		echo "- For : " $0; 
		echo "==========================TEST==========================" >> ./result.log
		echo "Test File : " $0  >> ./result.log
		echo "Testeds Command : \"" >> ./result.log
		cat $0 >> ./result.log
		echo "\"\n\n--------------------------DIFF--------------------------" >> ./result.log
		cat ./temps/diff >> ./result.log

		TEST_TEMP=$(($(cat ./temps/faild)+1))
		echo $TEST_TEMP > ./temps/faild
	else
		printf "$Green OK $Color_Off"
		TEST_TEMP=$(($(cat ./temps/succes)+1)) > ./temps/succes
		echo $TEST_TEMP > ./temps/succes
	fi
}

function testings ()
{
	# Run all test in directory
	# CATEGORY_TEST=$( echo $0 | sed 's/\([A-Za-z_-]\+\)\$/\1/')
	# CATEGORY_TEST=$( echo $0 | grep -oP '([A-Za-z0-9-_]+)$')
	printf "\n\nTESTING : ${Black} ${On_White} $( basename $0 ) ${Color_Off}\n";
	find $1 -type f -maxdepth 1 -exec sh -c 'test_case "$0"' {} \;
	
}

function run ()
{
	export -f testings;
	export -f test_case;
	# Getting all directory (Test Category)
	find ./Tests -type d -exec sh -c 'testings "$0"' {} \;
}


function setup_tester ()
{
	# Creating temps directory if dosent exit
	if [ ! -d "./temps" ]; then
		mkdir temps
	fi

	# Delete prevous log if exist
	rm -f ./result.log
	rm -f ./bash
	echo 0 > ./temps/faild
	echo 0 > ./temps/succes

	make -C $TESTED_SHELL_DIR > /dev/null
	mv $TESTED_SHELL ./bash
}


show_header
setup_tester
run
show_summary

# if [ "$1" = "test" ]; then
# 	test_case $2
# else
# 	run
# fi
