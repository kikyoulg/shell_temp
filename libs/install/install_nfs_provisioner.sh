#!/bin/bash

install_nfs_provisioner() {
    if [[ $(kubectl get pods -l app=nfs-subdir-external-provisioner -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != True ]]; then
        cd $pwd
        # echo -e "${nfs_path} *(insecure,rw,no_root_squash)" | sed 's/^[ ]*//g' | sudo tee /etc/exports >/dev/null
        sudo mkdir -p ${nfs_path}
        chmod +x helm && ./helm install nfs-subdir-external-provisioner tools/nfs-subdir-external-provisioner/ --set nfs.server=$master_ip --set nfs.path=$nfs_path
        for i in $(seq 1 20); do
            if [[ $(kubectl get pods -l app=nfs-subdir-external-provisioner -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != True ]]; then
                echo -e "\033[41;37m nfs_provisioner 服务安装中 \033[0m"
                sleep 10
            else
                echo -e "\033[42;37m nfs_provisioner 服务安装完成 \033[0m" && return 2
            fi
        done
        [[ $? -ne 2 ]] && echo -e "\033[41;37m nfs_provisioner 服务安装失败 \033[0m" && exit
    fi
}
