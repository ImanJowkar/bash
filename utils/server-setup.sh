!#/bin/bash

# This Bash script can do multiple things for you when you want to setup basic things


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



setup_shekan () {

cat /etc/resolv.conf | sed '/nameserver/ c\ nameserver 185.51.200.2' >>  /etc/resolv.conf



}






install_docker () {

    apt-get update
    apt-get install ca-certificates curl gnupg

    install -m 0755 -d /etc/apt/keyrings

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null

    apt-get update
    apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    touch /etc/docker/daemon.json
    cat << EOF > /etc/docker/daemon.json
{
  "registry-mirrors": ["https://docker.iranserver.com"]
}
EOF

    systemctl daemon-reload
    systemctl restart docker

}



print_style "\nThis script can do the folowing things for you, you can choose one of the below choices \n\n" "info";
PS3="Your choice: "

select ITEM in "Install Docker" "Setup Shekan" "Quit"
do
	if [[ $REPLY -eq 1 ]]
	then
        print_style "\n Installing docker, please wait..." "info";
        sleep 1
        install_docker

    elif [[ $REPLY -eq 2 ]]
	then
		print_style "Changing the name server..." "info";
		sleep 0.4
		setup_shekan

	elif [[ $REPLY -eq 3 ]]
	then
		print_style "Quitting..." "info";
		sleep 1
		exit
	else
		print_style "Invalid Menu selection. \n" "danger";
	fi
done


