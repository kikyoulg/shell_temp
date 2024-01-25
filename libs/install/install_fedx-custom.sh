#!/bin/bash

install_fedx-custom() {
    cd $pwd && chmod +x helm && ./helm install kafka tools/kafka/kafka -f config/${env}/middleware/kafka.yaml -n${fedx_custom_ns} --create-namespace
    ./helm install fedx-custom fedx-custom -f config/$env/fedx-custom/${party_id}.yaml -n${fedx_custom_ns} --create-namespace
    for i in $(seq 1 50); do
        if [[ "$(kubectl get pods -n${fedx_custom_ns} -o jsonpath='{.items[*].status.containerStatuses[0].ready}' | xargs -n1 | uniq)" != "true" ]]; then
            echo -e "\033[42;37m ${fedx_custom_ns} 服务安装中 \033[0m"
            sleep 10
        else
            kubectl delete $(kubectl get pod -n ${fedx_custom_ns} -l app=fedx-proxy -o name) -n${fedx_custom_ns} &&
                echo -e "\033[41;37m ${fedx_custom_ns} 服务安装完成 \033[0m" && return 2
        fi
    done
}
