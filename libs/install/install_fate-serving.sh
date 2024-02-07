#!/bin/bash

install_fate-serving() {
    cd $pwd
    ./kubefate chart upload -f tools/kubefate/fate-serving-v2.1.5.tgz
    kubectl get ns | grep $serving_ns || kubectl create ns $serving_ns
    ./kubefate cluster install -f config/$env/fate-serving/${party_id}.yaml
    sleep 20
    ./helm install proxy fate-serving/$serving_ns/ -f config/$env/fedx/$party_id.yaml -n$serving_ns --create-namespace
    for i in $(seq 1 50); do
        if [[ "$(kubectl get pods -n$serving_ns -o jsonpath='{.items[*].status.containerStatuses[0].ready}' | xargs -n1 | uniq)" != "true" ]]; then
            echo -e "\033[42;37m $serving_ns 服务安装中 \033[0m"
            sleep 10
        else
            kubectl get pod -n$serving_ns -l app=fate-serving-proxy -o name | xargs kubectl -n$serving_ns delete &&
                echo -e "\033[41;37m $serving_ns 服务安装完成 \033[0m" &&
                return 2
        fi
    done
}
