# bash-script

This [refrence](https://www.cyberithub.com/category/scripting/bash/) have useful bash excersize and best practice for learning bash


## variables
```
name=jack
age=32

os="Windows"
echo ${os}11

multi_var="$name $age"
echo "THis is multi-var: ${multi_var}"

echo "Hi $name, You are $age years old"

# constant variables > you can't set or delete this type of variables
declare -r var="This is constant variables"
echo $var

var="change me"
unset var



# read data from user and store it in a variable
read -p "Enter the IP address of domain to block: " IP
sudo iptables -I INPUT -s $IP -j DROP
echo "The packets from $IP will be dropped"

# read secret data
echo "Enter your password:"
read -s password
echo $password



var1=osLINx
echo ${var1}
echo ${var1^^}   # upper
echo ${var1,,}   # lower



# array
NAME[0]="Iman"
NAME[1]="Jafar"
NAME[2]="Gheysar"

echo ${NAME[1]}


for n in ${NAME[@]}
do 
echo $n
done


```

## Positional Parameters

```
echo $0   # is the name of the script itself (script.sh)
echo ${1:-default_value}   # is the first positional argument (filename1)
echo ${1:--100}   # is the first positional argument (filename1)
echo $2   # is the second positional argument 
echo $3   # is the last argument of the script
echo $9   # would be the ninthe argument and ${10} the tenth
echo $#   # is the number of the positional arguments


echo "$*" # is a string representation of all positional arguments: $1, $2, $3
echo $@   # same as above


echo $?   # is the most recent foreground command exit status
echo $$   # give the process ID of the shell


```


## conditions

```
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
}




if [[ $# -eq 1 ]]
then


	if [[ -f $1 ]]
	then
		print_style "\n you enter a file , so i want to print the content of this file" "info";
		sleep 1
		cat $1
	elif [[ -d $1 ]]
	then	
		print_style " \n you enter a directory so i want to list the detial of this dir , running 'ls -l' ..." "info";
		sleep 1
		ls -l $1

	else
		print_style "The argument ($1) is neither a file nor a directory." "warning";


	fi
else
	echo "The script should be run with an argument. "
	echo "Note that, Input can be a file or a directory"
fi


###############################
# double brakets
read -p "Enter your age: " age

if [[ $age -lt 18 ]] && [[ $age -ge 0 ]]
then
	echo "You are kid!"

elif [[ $age -eq 18 ]]
then
	echo "hey, you are a young man boy."

elif [[ $age -gt 18 ]] && [[ $age -le 100 ]]
then
	echo "You are old."
else
	echo "Ivalid age."
fi


##########################
# single brakets


read -p "Enter your age: " age

if [ $age -lt 18 -a $age -ge 0 ]
then
	echo "You are kid!"

elif [[ $age -eq 18 ]]
then
	echo "hey, you are a young man boy."

elif [ $age -gt 18 -a $age -le 100 ]
then
	echo "You are old."
else
	echo "Ivalid age."
fi


```



## compare string

```

read -p "String1: " str1
read -p "String2: " str2

if [ "$str1" = "$str2" ]
then
	echo "The strings are equal."

else
	echo "The strings are not equal."
fi

######################################
if [[ "$str1" == "$str2" ]]
then
        echo "The strings are equal."

else
        echo "The strings are not equal."
fi
#####################################

if [[ "$str1" != "$str2" ]];then
	echo "The strings are not equal."
fi

##########################################



# Check a word exist in a sentence: 

str1="Linux is a widely-used open-source operating system kernel that serves as the foundation for various Linux distributions, such as Ubuntu, Fedora, and Debian. Developed by Linus Torvalds in 1991, Linux is known for its stability, security, and flexibility, making it a popular choice for servers, supercomputers, embedded systems, and personal computers. Linux is characterized by its robust command-line interface, which allows users to interact with the system efficiently and perform a wide range of tasks. With a strong emphasis on community-driven development and collaboration, Linux has fostered a vibrant ecosystem of software and support, empowering users to customize their computing environments to suit their specific needs."

if [[ "$str1" == *linux* ]]
then
	echo "The substring linux is there."
else
	echo "The substring linux is not there."
fi










# check for empry string

my_str="asdf"

if [[ -z "$my_str" ]]
then
	echo "String is zero length."
else
	echo "String is not zero lenght"
fi


if [[ -n "$my_str" ]]
then
	echo "String is not zero length."
else
	echo "String is zero lenght."
fi

```


## loops

```

for name in apple iman jafar ehsan  "test"
do
	echo "name is: $name"
done




for i in {1..41}
do
	echo "number: $i"
done



for i in {10..400..50}
do
	echo "We are in iterate: $i"
done



```