#!/bin/bash

install_kubefate() {
    if [ $(grep -c "$master_ip kubefate.net" /etc/hosts) -eq '0' ]; then
        echo "$master_ip kubefate.net" | sudo tee -a /etc/hosts >/dev/null
    fi
    cd $pwd/
    chmod +x kubefate
    kubectl apply -f tools/kubefate/rbac-config.yaml -f tools/kubefate/kubefate.yaml
    for i in $(seq 1 20); do
        curl $master_ip:30099 >/dev/null 2>&1
        [[ $(echo $?) -eq 0 ]] && echo -e "\033[42;37m kube-fate 安装成功 \033[0m" && break
        echo -e "\033[41;37m kube-fate安装中 \033[0m" && sleep 5
    done
}
