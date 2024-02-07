#!/bin/bash
#清理数据库
reset_mysql() {
    array=(fedx-1000 fedx-1100 fedx-2000)
    for i in "${array[@]}"; do
        kubectl -n$i patch statefulset mysql -p '{"spec":{"replicas":0}}'
        kubectl -n$i delete pvc pvc-mysql
    done
}
