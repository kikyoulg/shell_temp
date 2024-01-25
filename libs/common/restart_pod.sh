#!/bin/bash

buttons=(
    "fedx-api"
    "fedx-job-api"
    "fedx-job-worker"
    "fedx-postman"
    "fedx-web"
    "fedx-helper"
    "fedx-doc"
    "python_1000"
    "python_1100"
    "python_2000"
    "注:fedx-api和fedx-web的更新包含fedx和fedx-custom"
)

button_num=${#buttons[@]}

fedx-api() {
    kubectl get pod -A|grep fedx-api | awk '{print "kubectl delete pod --force=true -n "$1" "$2}' | bash
}
fedx-job-api() {
    kubectl get pod -A|grep fedx-job-api | awk '{print "kubectl delete pod --force=true -n "$1" "$2}' | bash
}
fedx-job-worker() {
    kubectl get pod -A|grep fedx-job-worker | awk '{print "kubectl delete pod --force=true -n "$1" "$2}' | bash
}
fedx-web(){
  kubectl get pod -A|grep fedx-web | awk '{print "kubectl delete pod --force=true -n "$1" "$2}' | bash
}
fedx-helper(){
  kubectl get pod -A|grep fedx-helper | awk '{print "kubectl delete pod --force=true -n "$1" "$2}' | bash
}
fedx-doc(){
  kubectl get pod -A|grep fedx-doc | awk '{print "kubectl delete pod --force=true -n "$1" "$2}' | bash
}
fedx-postman() {
    kubectl get pod -A|grep fedx-postman | awk '{print "kubectl delete pod --force=true -n "$1" "$2}' | bash
}
python_1000() {
    kubectl get pod -nfate-1000 -l fateMoudle=python -o name|xargs kubectl -nfate-1000 delete
    kubectl get pod -nfate-1000 -l fateMoudle=nginx -o name|xargs kubectl -nfate-1000 delete
    kubectl get pod -nfate-1000 -l app=fate-proxy -o name|xargs kubectl -nfate-1000 delete
}
python_1100() {
    kubectl get pod -nfate-1100 -l fateMoudle=python -o name|xargs kubectl -nfate-1100 delete
    kubectl get pod -nfate-1100 -l fateMoudle=nginx -o name|xargs kubectl -nfate-1100 delete
    kubectl get pod -nfate-1100 -l app=fate-proxy -o name|xargs kubectl -nfate-1100 delete
}
python_2000() {
    kubectl get pod -nfate-2000 -l fateMoudle=python -o name|xargs kubectl -nfate-2000 delete
    kubectl get pod -nfate-2000 -l fateMoudle=nginx -o name|xargs kubectl -nfate-2000 delete
    kubectl get pod -nfate-2000 -l app=fate-proxy -o name|xargs kubectl -nfate-2000 delete
}

restart_pod() {
    local temp
    local i
    i=0
    while [ 1 ]
    do
        clear
        for((j=0;j<button_num;j++))
        do
            if [ $i -eq $j ]
            then
                echo -e "\033[32m ${buttons[$j]} \033[0m"
            else
                echo " ${buttons[$j]} "
            fi
        done
        read -s -n1 temp
        case "$temp" in
            "A")
                i=`expr $i - 1`
                [ $i -lt 0 ] && i=`expr $button_num - 1`
                ;;
            "B")
                i=`expr $i + 1`
                [ $i -ge $button_num ] && i=0
                ;;
            "")
                eval ${buttons[$i]}
                break
                ;;
        esac
    done
}
