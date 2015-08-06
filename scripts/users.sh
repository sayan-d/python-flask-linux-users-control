#!/bin/bash
#Author : Sayan Das

user=$1
tasktype=$2
action=$3
user4tharg=$4
task="$tasktype.$action"

chk() {
if [[ $? -eq 0 ]];then
	echo -e "The request was processed successfully"
else
	echo -e "The request failed to execute"
fi
}

systemuserchk() {
getuserid=`id -u $user`
if [[ $getuserid -lt 500 && $? -eq 0 ]];then
	echo -e "The user $user is a System User, Modifications not Allowed"
	exit 1
fi

`id $user > /dev/null`
if [[ $? -eq 0 && $task == "1.1" ]];then
	echo -e "The user $user already exists in system, it cannot be created. \n Please use modify."
	exit 1
fi
}
systemuserchk

selectfunction() {
	case $task in
		"1.1") echo -e "Create User Selected"; usercreate;;
		"1.2"|"1.3") echo -e "Modify/Delete User Selected"; userdelete;;
		"2.1") echo -e "Enable User Shell Access Selected"; usershellenable ;;
		"2.2"|"2.3") echo -e "Modify/Disable Shell Access Selected"; usershelldisable;;
		"3.1") echo -e "Create User Home Dir Selected"; moduserhome;;
		"3.2"|"3.3") echo -e "Modify User Home Directory Selected"; moduserhome;;
		"4.1") echo -e "Set User Password selected"; moduserpass;;
		"4.2"|"4.3") echo -e "Modify User Password Selected"; moduserpass;;
		"5.1") echo -e "Add sudo Access selected"; sudoaccessadd;;
		"5.2"|"5.3") echo -e "Remove sudo Access Selected"; sudoaccessdel;;
		*) echo "Sorry, TaskID = $task | Wrong Selection";;
	esac
}

userdetails() {
	bold=`tput bold`
	normal=`tput sgr0`
	echo -e "\n==# User Details #==\n"
	/usr/bin/finger -l $user | head -2
	id $user

}

usercreate() {
	useradd $user
	chk
}

userdelete() {
	userdel $user
	chk
}

usershellenable() {
	chsh -s /bin/bash $user
	echo -e "Shell access enabled for user $user"
	chk
}

usershelldisable() {
        chsh -s /sbin/nologin $user
	echo -e "Shell access disabled for user $user"
	chk
}

moduserhome() {
	/bin/ls $user4tharg > /dev/null
	if [[ $? -ne 0 ]];then
#		echo -e "The specified directory $user4tharg already exists, please give a new path"
		mkdir -p $user4tharg
		chown -R $user:$user $user4tharg
		usermod -m -d $user4tharg $user
		echo -e "Home Directory of $user set successfully to : $user4tharg"
		chk
	elif [[ $user4tharg == "/home/$user" ]];then
		usermod -m -d $user4tharg $user
		echo -e "Home Directory of $user set successfully to : $user4tharg"
		chk
	else
		echo -e "The specified directory $user4tharg already exists, please give a new path"
	fi
}

moduserpass() {
	echo "$user4tharg" | passwd --stdin $user
	echo -e "Password for user $user modified successfully"
	chk
}

sudoaccessadd() {
	usermod -a -G wheel $user
	echo -e "Sudo access granted to user $user"
	chk
}

sudoaccessdel() {
	usermod -G wheel $user
	echo -e "Sudo access revoked for user $user"
	chk
}

selectfunction
userdetails
