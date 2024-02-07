#!/bin/bash

uninstall_fate-serving() {
    cd $pwd
    if [[ $fate_ns == fate-1000 ]]; then
        ./kubefate cluster del $(./kubefate cluster ls | grep fate-serving-1000 | awk '{print $1}')
        ./helm uninstall proxy -n fate-serving-1000 --wait --timeout 2m
    elif [[ $fate_ns == fate-1100 ]]; then
        ./kubefate cluster del $(./kubefate cluster ls | grep fate-serving-1100 | awk '{print $1}')
        ./helm uninstall proxy -n fate-serving-1100 --wait --timeout 2m
    else
        ./kubefate cluster del $(./kubefate cluster ls | grep fate-serving-2000 | awk '{print $1}')
        ./helm uninstall proxy -n fate-serving-2000 --wait --timeout 2m
    fi
}
