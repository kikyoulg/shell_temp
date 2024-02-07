#!/bin/bash

uninstall_fedx() {
    cd $pwd && ./helm uninstall fedx -n$fedx_ns --wait --timeout 3m
    [[ $? -eq 0 ]] && echo -e "\033[42;37m $fedx_ns 卸载成功 \033[0m" || echo -e "\033[41;37m $fedx_ns卸载失败 \033[0m"
    echo -e "\033[41;37m $fedx_ns 卸载成功 \033[0m"
}
