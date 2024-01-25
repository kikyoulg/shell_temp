#!/bin/bash

install_fate() {
    kubectl get ns | grep $fate_ns || kubectl create ns $fate_ns
    cd $pwd && ./kubefate chart upload -f tools/kubefate/fate-v1.7.2-fedx-persistence.tgz && ./kubefate cluster install -f config/$env/fate/${party_id}.yaml
    sleep 20

    ./helm install proxy fate/$fate_ns/ -f config/$env/fedx/$party_id.yaml -n$fate_ns
    bash fate/$fate_ns/nginx-config-patch.sh

    cd $pwd/fate/extension
    kubectl apply -f feature-transform/feature-transform.yaml -n $fate_ns
    kubectl apply -f scorecard/scorecard-cm.yaml -n $fate_ns

    kubectl patch deployment client --patch-file feature-transform/client-patch.yaml -n $fate_ns
    kubectl patch deployment python --patch-file feature-transform/python-patch.yaml -n $fate_ns
    kubectl patch deployment spark-worker --patch-file feature-transform/spark-worker-patch.yaml -n $fate_ns

    kubectl set env deployment/pulsar PULSAR_MEM='-Xms8g  -Xmx8g  -XX:MaxDirectMemorySize=16g' -n$fate_ns

    sleep 20

    # kubectl wait -l fateMoudle=python --for=condition=ready pod --timeout=66s -n$fate_ns
    # kubectl wait -l fateMoudle=pulsar --for=condition=ready pod --timeout=66s -n$fate_ns

    for i in $(seq 1 100); do
        if [[ "$(kubectl get pods -n$fate_ns -o jsonpath='{.items[*].status.containerStatuses[0].ready}' | xargs -n1 | uniq)" != "true" ]]; then
            echo -e "\033[41;37m $fate_ns 服务安装中 \033[0m"
            sleep 10
        else
            kubectl delete $(kubectl get pod -n $fate_ns -l fateMoudle=nginx -o name) -n$fate_ns &&
                kubectl delete $(kubectl get pod -n $fate_ns -l app=fate-proxy -o name) -n$fate_ns &&
                echo -e "\033[42;37m $fate_ns 服务安装完成 \033[0m" &&
                return 2
        fi
    done
    [[ $? -ne 2 ]] && echo -e "\033[41;37m $fate_ns 服务安装失败 \033[0m" && exit

}
