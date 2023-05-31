#!/bin/bash


# prints colored text
print_style () {

    if [ "$2" == "info" ] ; then
        COLOR="96m";
    elif [ "$2" == "success" ] ; then
        COLOR="92m";
    elif [ "$2" == "warning" ] ; then
        COLOR="93m";
    elif [ "$2" == "danger" ] ; then
        COLOR="91m";
    else #default color
        COLOR="0m";
    fi

    STARTCOLOR="\e[$COLOR";
    ENDCOLOR="\e[0m";

    printf "$STARTCOLOR%b$ENDCOLOR" "$1";
}

# print_style "This is a green text " "success";
# print_style "This is a yellow text " "warning";
# print_style "This is a light blue with a \t tab " "info";
# print_style "This is a red text with a \n new line " "danger";
# print_style "This has no color";




print_style "\nThis script can do the folowing things for you, you can choose one of the below choices \n\n" "info";
PS3="Your choice: "

select ITEM in "Add User" "List All Processes" "Kill Process" "Install Program" "Quit" "Delete User"
do
	if [[ $REPLY -eq 1 ]]
	then
		read -p "Enter The username: " username
		output="$(grep -w $username /etc/passwd)"
		if [[ -n "$output" ]]
		then
			print_style "The username already exists. \n" "warning";
		else
			sudo adduser "$username"
			if [[ $? -eq 0 ]]
			then
				print_style "The user $username was added successfully.\n" "success";
				tail -n 1 /etc/passwd
			else
				print_style "There was an error adding the user $username \n" "danger";
			fi
		fi
	elif [[ $REPLY -eq 2 ]]
	then
		print_style "Listing all processes...\n" "info";
		sleep 1
		ps -ef

	elif [[ $REPLY -eq 3 ]]
	then
		read -p "Enter The process to kill: " process
		pkill $process

	elif [[ $REPLY -eq 4 ]]
	then
		read -p "Enter the program to install: " app
		sudo apt update && sudo apt install $app

	elif [[ $REPLY -eq 5 ]]
	then
		print_style "Quitting..." "info";
		sleep 1
		exit
	elif [[ $REPLY -eq 6 ]]
	then
		read -p "Enter The username for delete: " username
		if [ "$username" = "$USER" ] || [ "$username" = "root" ]
		then
			print_style "You can't remove this user $username" "danger";
			break
		fi
		output="$(grep -w $username /etc/passwd)"
		if [[ -n "$output" ]]
		then
			print_style "The username already exists. so deleted in 5 second, you can press 'ctrl+c' to cancel it \n" "warning";
			sleep 5
			sudo deluser "$username"
			sudo rm -rf /home/$username
			if [[ $? -eq 0 ]]
			then
				print_style "The user $username deleted successfully. \n" "success";
			else
				print_style "There was an error deleting the user $username \n" "danger";
			fi

		else
			print_style "the user $username does not exists. \n" "warning";
		fi
	else
		print_style "Invalid Menu selection. \n" "danger";
	fi
done

