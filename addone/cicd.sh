#!/bin/bash

cd /tmp/cicd

buttons=(
    "bsd-adaptor"
    "bsd-container"
    "bsd-transfer"
    "bsd-resource"
    "bsd-workflow"
    "bsd-web"
    "fedx-data-backup"
    "bsd-all"
    "custom-fedx-web"
)

button_num=${#buttons[@]}

rsc-fe-spd() {
  echo "rsc-fe-spd"
}
bsd-adaptor(){
  sudo rm -rf bsd-adaptor-0.0.1-SNAPSHOT.jar
  kubectl cp `kubectl get pod -nbsd-1000 |awk '{print $1}'|grep adaptor`:/app/bsd-adaptor-0.0.1-SNAPSHOT.jar ./bsd-adaptor-0.0.1-SNAPSHOT.jar -nbsd-1000
}
bsd-container(){
  sudo rm -rf bsd-container-0.0.1-SNAPSHOT.jar
  kubectl cp `kubectl get pod -nbsd-1000 |awk '{print $1}'|grep container`:/app/bsd-container-0.0.1-SNAPSHOT.jar ./bsd-container-0.0.1-SNAPSHOT.jar -nbsd-1000
}
bsd-transfer(){
  sudo rm -rf bsd-transfer-0.0.1-SNAPSHOT.jar
  kubectl cp `kubectl get pod -nbsd-1000 |awk '{print $1}'|grep transfer`:/app/bsd-transfer-0.0.1-SNAPSHOT.jar ./bsd-transfer-0.0.1-SNAPSHOT.jar -nbsd-1000
}
bsd-resource(){
  sudo rm -rf resource-api-0.0.1-SNAPSHOT.jar
  kubectl cp `kubectl get pod -nbsd-1000 |awk '{print $1}'|grep resource`:/app/resource-api-0.0.1-SNAPSHOT.jar ./resource-api-0.0.1-SNAPSHOT.jar -nbsd-1000
}
bsd-workflow(){
  sudo rm -rf workflow-api-0.0.1-SNAPSHOT.jar
  kubectl cp `kubectl get pod -nbsd-1000 |awk '{print $1}'|grep workflow`:/app/workflow-api-0.0.1-SNAPSHOT.jar ./workflow-api-0.0.1-SNAPSHOT.jar -nbsd-1000
}
bsd-web(){
  sudo rm -rf html.tgz
  kubectl cp `kubectl get pod -nbsd-1000 |awk '{print $1}'|grep web`:/usr/share/nginx/ ./ -nbsd-1000
  tar -zcvf html.tgz html && rm -rf html
}
fedx-data-backup(){
  sudo rm -rf backup-0.0.1-SNAPSHOT.jar
  kubectl cp `kubectl get pod -nfate-1000 |awk '{print $1}'|grep fedx-data-backup`:/app/backup-0.0.1-SNAPSHOT.jar ./backup-0.0.1-SNAPSHOT.jar -nfate-1000
}
bsd-all(){
  rm -rf *
  kubectl cp `kubectl get pod -nbsd-1000 |awk '{print $1}'|grep adaptor`:/app/bsd-adaptor-0.0.1-SNAPSHOT.jar ./bsd-adaptor-0.0.1-SNAPSHOT.jar -nbsd-1000
  kubectl cp `kubectl get pod -nbsd-1000 |awk '{print $1}'|grep container`:/app/bsd-container-0.0.1-SNAPSHOT.jar ./bsd-container-0.0.1-SNAPSHOT.jar -nbsd-1000
  kubectl cp `kubectl get pod -nbsd-1000 |awk '{print $1}'|grep transfer`:/app/bsd-transfer-0.0.1-SNAPSHOT.jar ./bsd-transfer-0.0.1-SNAPSHOT.jar -nbsd-1000
  kubectl cp `kubectl get pod -nbsd-1000 |awk '{print $1}'|grep resource`:/app/resource-api-0.0.1-SNAPSHOT.jar ./resource-api-0.0.1-SNAPSHOT.jar -nbsd-1000
  kubectl cp `kubectl get pod -nbsd-1000 |awk '{print $1}'|grep workflow`:/app/workflow-api-0.0.1-SNAPSHOT.jar ./workflow-api-0.0.1-SNAPSHOT.jar -nbsd-1000
  kubectl cp `kubectl get pod -nbsd-1000 |awk '{print $1}'|grep web`:/usr/share/nginx/ ./ -nbsd-1000
  tar -zcvf html.tgz html && rm -rf html
}
custom-fedx-web(){
  sudo docker pull registry.zet-fl.com/fedx/fedx-shanghai-spdb-web:v4.2.1
  sudo docker save registry.zet-fl.com/fedx/fedx-shanghai-spdb-web:v4.2.1 |pigz -9 >custom-fedx-web.tgz
}

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
