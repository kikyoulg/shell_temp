#!/bin/bash

uninstall_fate() {
    cd $pwd
    ./kubefate cluster del $(./kubefate cluster ls | grep $fate_ns | grep -v UUID | awk '{print $1}')
    ./helm uninstall proxy -n$fate_ns --wait --timeout 2m
    echo -e "\033[41;37m $fate_ns 卸载成功 \033[0m"
}
