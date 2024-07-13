#!/bin/bash


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
    echo ""
}



ManageProc() {

PS3="Select Item....."
select CHOICE in "Top 10 CPU% Usage" "Process More Than X CPU Usage(in %)" "Process More X Memory Usage" "Zombie Process" "Kill Process" "Exit";do
	case $REPLY in
		1)
			
			print_style "`ps aux --sort=-%cpu | head -n 10`"  "info"; 
			;;
		
		2)
			read -p "Please input your CPU% Usage percentage like 10.0: " threshold 
			print_style "`ps -ax --sort=-%cpu --format pid,ppid,%cpu,%mem,cmd | awk -v threshold=$threshold '{ if ($3 > threshold ) print $0}'`" "warning";
			;;
		3)

			read -p "Please input your Memory% Usage percentage like: 10.0:  " threshold
			print_style "`ps -ax --sort=-%mem --format pid,ppid,%cpu,%mem,cmd | awk -v threshold=$threshold '{if ($4 > threshold ) print $0}'`" "warning";
			;;

		4)
			echo This is Zombie Process, please kill them.
			print_style "`ps -ax  --format pid,ppid,%cpu,%mem,cmd,stat | awk  '$6 == "Z" { print $0 }'`" "danger";
			;;

		5)
			read -p "Enter the PID of the process which you want to delete it: " ProcessID
			read -p "Enter the signal which you want to send it to the process: " signal
			kill -$signal $ProcessID
			if [[ $? -eq 0 ]]
			then
				echo "the pid: $PID is successfully killed."
			fi
			;;
		6)
			break
			;;

			

	esac
done

}







PS3="What do you Want to do: "
select fruit in "Manage your Process." "Adding a user." "Adding a iptables rule." "Managing your filesystem." "Install or uninstall an app." Quit
do

	case $REPLY in
		1)
			echo "Manage your Process."
			ManageProc
			;;
		2)
			echo "Adding a user."
			;;
		3)
			echo "Adding a iptables rule."
			;;
		4)
			echo "Managing your filesystem."
			;;
		5)
			echo "Install or uninstall an app."
			;;
		6)
			echo "Quitting"
			sleep 1
			break
			;;
		*)
			echo "bad input!!!"
			;;
	esac
done 





