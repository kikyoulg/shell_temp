#!/bin/bash

reset() {
    cd $pwd
    #uninstall_fate
    for i in $(./kubefate cluster ls | grep -v UUID | awk '{print $1}'); do
        ./kubefate cluster del $i
    done
    #un proxy
    for i in {fate-1000,fate-1100,fate-2000}; do
        ./helm uninstall proxy -n$i
    done
    #un middleware
    for i in {fedx-1000,fedx-1100,fedx-2000}; do
        ./helm uninstall clickhouse-cluster -n$i
        ./helm uninstall kafka -n$i
        ./helm uninstall redis -n$i
    done
    #un fedx
    for i in {fedx-1000,fedx-1100,fedx-2000}; do
        ./helm uninstall fedx -n$i
    done
    #check status
    sleep 100
    #del pvc/pv
    for i in {fedx-1000,fedx-1100,fedx-2000}; do
        kubectl get pvc -n$i | grep -v NAME | awk '{print $1}' | xargs kubectl -n$i delete pvc
    done
    echo -e "\033[41;37m 卸载成功,准备重装 \033[0m" && sleep 10
    #install
    #install fate
    for fate_ns in {fate-1000,fate-1100,fate-2000}; do
        if [ $fate_ns == fate-1000 ]; then
            party_id=1000
            install_fate
        elif [ $fate_ns == fate-1100 ]; then
            party_id=1100
            install_fate
        else
            party_id=2000
            install_fate
        fi
    done
    #install fate-serving
    for fate_ns in {fate-1000,fate-1100,fate-2000}; do
        if [ $fate_ns == fate-1000 ]; then
            party_id=1000
            install_fate_serving
        elif [ $fate_ns == fate-1100 ]; then
            party_id=1100
            install_fate_serving
        else
            party_id=2000
            install_fate_serving
        fi
    done
    #install middleware
    for fedx_ns in {fedx-1000,fedx-1100,fedx-2000}; do
        install_middleware
    done
    #install fedx
    for fedx_ns in {fedx-1000,fedx-1100,fedx-2000}; do
        install_fedx
    done
}
