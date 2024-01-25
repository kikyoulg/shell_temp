#!/bin/bash

# env_check(){
#     for p in $(cat $pwd/config/$env/ip.txt | sed -n '1!p');do
#         user=$(echo "$p"|cut -f1 -d":")
#         ip=$(echo "$p"|cut -f2 -d":")
#         password=$(echo "$p"|cut -f3 -d":")
#         port=$(echo "$p"|cut -f4 -d":")

#         ssh $user@$ip -p$port "cd check_point"

#     done
# }

env_check() {
	user_check
	kernel_check
}

user_check() {
	if [ $USER != fedx ]; then
		echo -e "\033[41;37m 脚本必须用fedx用户执行 \033[0m"
		exit
	else
		echo -e "\033[42;37m 脚本执行用户确认OK \033[0m"
	fi
}

kernel_check() {
	if [ "$(uname -a | awk '{print $3}')" != "3.10.0-1160.el7.x86_64" ]; then
		echo -e "\033[41;37m 内核版本必须为3.10.0-1160.el7.x86_64 \033[0m"
		exit
	else
		echo -e "\033[42;37m 内核版本确认OK \033[0m"
	fi
}
