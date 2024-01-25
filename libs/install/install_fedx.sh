#!/bin/bash

install_fedx() {
    cd $pwd && chmod +x helm && ./helm install fedx fedx -f config/$env/fedx/$party_id.yaml -n$fedx_ns --create-namespace
    for i in $(seq 1 50); do
        if [[ "$(kubectl get pods -n$fedx_ns -o jsonpath='{.items[*].status.containerStatuses[0].ready}' | xargs -n1 | uniq)" != "true" ]]; then
            echo -e "\033[41;37m $fedx_ns 服务安装中 \033[0m"
            sleep 10
        else
            echo -e "\033[42;37m $fedx_ns 服务安装完成 \033[0m" && return 2
        fi
    done
    [[ $? -ne 2 ]] && echo -e "\033[41;37m $fedx_ns 服务安装失败 \033[0m" && exit
}
