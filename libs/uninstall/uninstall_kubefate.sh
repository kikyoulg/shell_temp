#!/bin/bash

uninstall_kubefate() {
    cd $pwd
    kubectl delete -f tools/kubefate/rbac-config.yaml && sudo sed -i "/${master_ip} kubefate.net/d" /etc/hosts
    echo -e "\033[42;37m kube-fate 卸载成功 \033[0m"
}
