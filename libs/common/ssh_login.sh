#!/bin/bash

ssh_login() {
    [[ -e "/home/fedx/.ssh/id_rsa" ]] || ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ''
    if ! expect -v &>/dev/null; then sudo yum -y localinstall $pwd/tools/rpm/expect/*.rpm; fi
    for p in $(cat $pwd/config/$env/ip.txt | sed -n '1!p'); do
        user=$(echo "$p" | cut -f1 -d":")
        ip=$(echo "$p" | cut -f2 -d":")
        password=$(echo "$p" | cut -f3 -d":")
        port=$(echo "$p" | cut -f4 -d":")
        expect -c "
    spawn ssh-copy-id $user@$ip -p$port
            expect {
                    \"*yes/no*\" {send \"yes\r\"; exp_continue}
                    \"*password*\" {send \"$password\r\"; exp_continue}
                    \"*Password*\" {send \"$password\r\";}
            }
    "
    done
}
