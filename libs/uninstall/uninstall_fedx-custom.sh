#!/bin/bash

uninstall_fedx-custom() {
    cd $pwd
    ./helm uninstall kafka -n${fedx_custom_ns} --wait --timeout 3m
    ./helm uninstall fedx-custom -n${fedx_custom_ns} --wait --timeout 3m
    [[ $? -eq 0 ]] && echo -e "\033[42;37m ${fedx_custom_ns} 卸载成功 \033[0m" || echo -e "\033[41;37m $fedx_ns卸载失败 \033[0m"
    echo -e "\033[41;37m ${fedx_custom_ns} 卸载成功 \033[0m"
}
