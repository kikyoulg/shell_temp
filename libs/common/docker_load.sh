#!/bin/bash

import_docker_images() {
    echo -e "\033[41;37m master节点开始导入镜像 \033[0m"
        for f in $pwd/tools/images/*.tgz; do
            sudo docker load -i $f
        done
    for p in $(cat $pwd/config/$env/ip.txt | sed -n '1!p'); do
        user=$(echo "$p" | cut -f1 -d":")
        ip=$(echo "$p" | cut -f2 -d":")
        password=$(echo "$p" | cut -f3 -d":")
        port=$(echo "$p" | cut -f4 -d":")

        scp -P$port -r $pwd/../fedx-install $user@$ip:
        echo -e "\033[41;37m $ip 节点开始导入镜像 \033[0m"
        for f in $pwd/tools/images/*.tgz; do
            ssh $user@$ip -p$port "sudo docker load -i $f"
        done
    done
}
