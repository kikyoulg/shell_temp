#!/bin/bash

install_nfs() {
    [[ ! -d "$nfs_path/datax/$fedx_ns" ]] && sudo mkdir -p $nfs_path/$party_id/secret
    for p in $(cat $pwd/config/$env/ip.txt | sed -n '1!p'); do
        user=$(echo "$p" | cut -f1 -d":")
        ip=$(echo "$p" | cut -f2 -d":")
        password=$(echo "$p" | cut -f3 -d":")
        port=$(echo "$p" | cut -f4 -d":")
        echo -e "\033[41;37m $ip 开始安装nfs \033[0m"
        ssh $user@$ip -p$port "! showmount -h &>/dev/null && sudo yum localinstall -y $pwd/tools/rpm/nfs/*.rpm \
                                && sudo systemctl enable --now rpcbind \
                                && sudo systemctl enable --now nfs"
    done

    if ! showmount -h &>/dev/null;then sudo yum localinstall -y $pwd/tools/rpm/nfs/*.rpm;fi

    echo -e "$nfs_path *(insecure,rw,no_root_squash)\n"  | sed 's/^[ ]*//g' | sudo tee /etc/exports  >/dev/null  \
    && sudo systemctl restart rpcbind;sudo systemctl enable rpcbind && sudo systemctl restart nfs;sudo systemctl enable nfs

    echo -e "$nfs_path *(insecure,rw,no_root_squash)" | sed 's/^[ ]*//g' | sudo tee /etc/exports >/dev/null
    sudo systemctl restart nfs
}
